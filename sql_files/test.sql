create table source_test
(
    channel varchar,
    name    varchar
)with(
     type ='kafka11',
     bootstrapservers ='127.0.0.1:9092',
     zookeeperquorum ='127.0.0.1:2181/kafka',
     offsetreset ='latest',
     topic ='test',
     groupid='test',
     parallelism ='1',
     timezone='asia/shanghai'
     );

create table sink_test
(
    pv       bigint,
    channel  varchar,
    ts_start timestamp,
    ts_end   timestamp
) with (
      type ='console',
      parallelism ='1'
      );

insert into sink_test
select count(*)                                       pv,
       channel,
       tumble_start(proctime, interval '5' minute) as ts_start,
       tumble_end(proctime, interval '5' minute)   as ts_end
from source_test
group by tumble(proctime, interval '5' minute), channel;