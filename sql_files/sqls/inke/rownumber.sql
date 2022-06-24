-- "SELECT order_id, user, product, number " +
--   "FROM (" +
--   "   SELECT *," +
--   "       ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY proctime ASC) as row_num" +
--   "   FROM Orders)" +
--   "WHERE row_num = 1"

-- sql.ttl.min=5h
-- sql.ttl.max=6h
-- sql.checkpoint.interval=120000
-- sql.checkpoint.mode=EXACTLY_ONCE
-- sql.checkpoint.timeout=180000

CREATE view v_readom_ads_userprofile_recall as
select 2 _version
      , 'kfk_readom_ads_profile_recall'     _source
 	  , 'readom'      						_app
      , 'userprofile'           			    _version_type
	  , uid           						_id
      , ts_end        						_time
      , CollectSet2Str(item) 				u_prefer_item_h
from (
         SELECT uid
              , date_format(ts_end, 'yyyyMMddHHmmss')                             ts_end
              , concat_ws(':', cast(novel_id as varchar), cast(score as varchar)) item
              , row_number() over (partition by uid order by score desc )         row_num
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