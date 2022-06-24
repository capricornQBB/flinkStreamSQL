/*
kfk_readom_ads_userprofile_recall
FROM:
-- readom_ods_binlog:chapter_buy_record
-- readom_ods_applog_action:readom_app_reading_time
-- readom_ods_applog_common:readom_app_add_book,readom_app_readguide_collect
TO:
-- kfk:singapore-kafka#middle_rec_real_user_profile_attrsync

VERSION:
-- 20220621 tanweiquan 用户画像-实时召回:https://wiki.inkept.cn/pages/viewpage.action?pageId=251175206
*/


create AGGREGATE function CollectSet2Str with udf.CollectSet2StrFunction;

CREATE TABLE readom_ods_binlog
(
    time            timestamp   as rtime,
    topic           varchar,
    data.uid        varchar     as uid,
    data.novel_id   varchar     as novel_id,
    data.status     varchar     as status,
    WATERMARK FOR rtime as withOffset(rtime, 2000)
) with (
      type = 'kafka11',
      bootstrapServers = 'kafka01.dsj.sg.inkept.cn:9092,kafka02.dsj.sg.inkept.cn:9092,kafka03.dsj.sg.inkept.cn:9092',
      offsetReset = 'latest',
      topic = 'app_readom_binlog',
      parallelism = '4',
      groupId = 'cop.inke_owt.data_pdl.readom_ads_profile_recall_prod',
      topicIsPattern = 'false',
      startupMode = 'GROUP_OFFSETS',
      logText = 'log_json'
      );

CREATE TABLE readom_ods_applog_action
(
    md_eid                   varchar,
    uid                      varchar,
    md_einfo.novel_id        varchar         as novel_id,
    md_einfo.readduring      bigint          as readduring, -- 毫秒
    record_time              bigint,
    WATERMARK FOR record_time as withOffset(record_time, 2000)
) with (
      type = 'kafka11',
      bootstrapServers = 'kafka01.dsj.sg.inkept.cn:9092,kafka02.dsj.sg.inkept.cn:9092,kafka03.dsj.sg.inkept.cn:9092',
      offsetReset = 'latest',
      topic = 'readom_applog_action',
      parallelism = '4',
      groupId = 'cop.inke_owt.data_pdl.readom_ads_profile_recall_prod',
      topicIsPattern = 'false',
      startupMode = 'GROUP_OFFSETS',
      logText = 'log_json'
      );

CREATE TABLE readom_ods_applog_common
(
    md_eid                   varchar,
    uid                      varchar,
    md_einfo.novelid         varchar     as novelid,    -- readom_app_add_book
    md_einfo.novel_id        varchar     as novel_id,   -- readom_app_readguide_collect
    record_time              bigint,
    WATERMARK FOR record_time as withOffset(record_time, 2000)
) with (
      type = 'kafka11',
      bootstrapServers = 'kafka01.dsj.sg.inkept.cn:9092,kafka02.dsj.sg.inkept.cn:9092,kafka03.dsj.sg.inkept.cn:9092',
      offsetReset = 'latest',
      topic = 'readom_applog_common',
      parallelism = '2',
      groupId = 'cop.inke_owt.data_pdl.readom_ads_profile_recall_prod',
      topicIsPattern = 'false',
      startupMode = 'GROUP_OFFSETS',
      logText = 'log_json'
      );

create table cs_readom_ads_userprofile_recall
(
    _version  				int,
    _source   				varchar,
    _app      				varchar,
    _version_type  			varchar,
    _id             		varchar,
    _time           		varchar,
     u_prefer_item_h         varchar
) with (
      type = 'console',
      parallelism = '1'
      );

create table kfk_readom_ads_userprofile_recall
(
    _version  				int,
    _source   				varchar,
    _app      				varchar,
    _version_type  			varchar,
    _id             		varchar,
    _time           		varchar,
     u_prefer_item_h         varchar
) with (
    type = 'kafka11',
    bootstrapServers = 'kafka01.dsj.sg.inkept.cn:9092,kafka02.dsj.sg.inkept.cn:9092,kafka03.dsj.sg.inkept.cn:9092',
    -- zookeeperQuorum = 'zk01.dsj.sg.inkept.cn:2181,zk02.dsj.sg.inkept.cn:2181,zk03.dsj.sg.inkept.cn:2181'
    topic='middle_rec_real_user_profile_attrsync',
    parallelism ='5',
    topicIsPattern ='false',

 );

CREATE view v_readom_ads_userprofile_recall as
select 2             						_version
      , 'kfk_readom_ads_profile_recall'     _source
 	  , 'readom'      						_app
      , 'userprofile'           			_version_type
	  , uid           						_id
      , ts_end        						_time
      , CollectSet2Str(item) 				u_prefer_item_h
from (
         SELECT uid
              , date_format(ts_end, 'yyyyMMddHHmmss')                       ts_end
              , concat_ws(':', novel_id, cast(score as varchar))            item
              , row_number() over (partition by uid order by score desc )   row_num
         FROM (select uid
                    , novel_id
                    , sum(score)                                                 score
                    , HOP_START(ROWTIME, INTERVAL '1' MINUTE, INTERVAL '5' HOUR) ts_start
                    , HOP_END(ROWTIME, INTERVAL '1' MINUTE, INTERVAL '5' HOUR)   ts_end
               from (
                        select uid
                             , novel_id
                             , 10 score
                             , ROWTIME
                        from readom_ods_binlog
                        WHERE topic = 'chapter_buy_record' -- 付费
                          and status = '2'                 -- 支付成功
                          and uid is not null
                          and novel_id is not null

                        union all

                        select uid
                             , novel_id
                             , case
                                   when readduring >= 0 and readduring <= 60 * 1000 then 1
                                   when readduring > 60 * 1000 and readduring <= 7 * 60 * 1000 then 2
                                   when readduring > 7 * 60 * 1000 and readduring <= 60 * 60 * 1000 then 3
                                   when readduring > 60 * 60 * 1000 then 4
                                   else 0
                            end score
                             , ROWTIME
                        from readom_ods_applog_action
                        where md_eid = 'readom_app_reading_time' -- 阅读时长
                          and uid is not null
                          and novel_id is not null

                        union all

                        select uid
                             , COALESCE(novel_id, novelid) novel_id
                             , 4                           score
                             , ROWTIME
                        from readom_ods_applog_common
                        where md_eid in ('readom_app_add_book', 'readom_app_readguide_collect') -- 收藏
                          and uid is not null
                          and COALESCE(novel_id, novelid) is not null
                    ) t
               group by HOP(ROWTIME, INTERVAL '1' MINUTE, INTERVAL '5' HOUR), uid, novel_id
              ) tt
     ) ttt
where row_num <= 10
group by uid
       , ts_end
;


insert
into kfk_readom_ads_userprofile_recall
select
    _version
        ,_source
        ,_app
        ,_version_type
        ,_id
        ,_time
        ,u_prefer_item_h
from v_readom_ads_userprofile_recall;

insert
into cs_readom_ads_userprofile_recall
select
    _version
        ,_source
        ,_app
        ,_version_type
        ,_id
        ,_time
        ,u_prefer_item_h
from v_readom_ads_userprofile_recall
;