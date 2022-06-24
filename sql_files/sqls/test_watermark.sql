create table source_test
(
    uid         varchar,
    record_time bigint,
    WATERMARK FOR record_time as withOffset(record_time, 2000)
--     TO_TIMESTAMP(FROM_UNIXTIME(record_time, 'yyyy-MM-dd HH:mm:ss')) timestamp as rtime,
--
)with(
     type ='kafka11',
     bootstrapservers ='127.0.0.1:9092',
     zookeeperquorum ='127.0.0.1:2181/kafka',
     offsetreset ='latest',
     topic ='test',
     groupid='test',
     parallelism ='1',
     topicIsPattern = 'false',
     startupMode = 'GROUP_OFFSETS',
     logText = 'log_json'
     );

create table sink_test
(
    pv       bigint,
    uid      varchar,
    ts_start timestamp,
    ts_end   timestamp
) with (
      type ='console',
      parallelism ='1'
      );

insert into sink_test
select count(*)                                      pv,
       uid,
       TUMBLE_START(ROWTIME, interval '1' minute) as ts_start,
       TUMBLE_END(ROWTIME, interval '1' minute)   as ts_end
from source_test
group by TUMBLE(ROWTIME, interval '1' minute), uid;

create table sink_readom_test_console
(
    pv       bigint,
    uid      varchar,
    ts_start timestamp,
    ts_end   timestamp
) with (
      type = 'console',
      parallelism = '1'
      );

insert into sink_readom_test_console
select count(*)                                      pv,
       uid,
       TUMBLE_START(ROWTIME, interval '1' minute) as ts_start,
       TUMBLE_END(ROWTIME, interval '1' minute)   as ts_end
from (select uid,
             ROWTIME
      from source_readom_applog_action_kfk
      where md_eid = 'readom_app_reading_time') t
group by TUMBLE(ROWTIME, interval '1' minute), uid;
;