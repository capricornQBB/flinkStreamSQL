create AGGREGATE function CollectSet2Str with udaf.CollectSet2StrFunction;
create AGGREGATE function CollectSet with udaf.CollectSetFunction;

create table source_test
(
    uid   varchar,
    email varchar
)with(
     type ='kafka11',
     bootstrapservers ='127.0.0.1:9092',
     zookeeperquorum ='127.0.0.1:2181/kafka',
     offsetreset ='latest',
     topic ='test',
     groupid='test',
     parallelism ='1'
     );

create table sink_test
(
    uid      varchar,
    emails   varchar,
    ts_start timestamp,
    ts_end   timestamp
) with (
      type ='console',
      parallelism ='1'
      );

insert into sink_test
select uid,
       CollectSet2Str(email)           as emails,
       tumble_start(PROCTIME, interval '1' minute) as ts_start,
       tumble_end(PROCTIME, interval '1' minute)   as ts_end
from source_test
group by tumble(PROCTIME, interval '1' minute), uid;