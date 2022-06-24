create table source_test
(
    id      varchar,
    channel varchar,
    name    varchar
)with(
     type ='kafka11',
     bootstrapservers ='127.0.0.1:9092',
     zookeeperquorum ='127.0.0.1:2181/kafka',
     offsetreset ='latest',
     topic ='test',
     groupid='test',
     parallelism ='1'
--      timezone='asia/shanghai'
     );

create table sink_test_console
(
    id      varchar,
    channel varchar,
    name    varchar
) with (
      type ='console',
      parallelism ='1'
);

CREATE TABLE sink_test_hbase
(
    dim:id varchar,
    dim:channel varchar,
    dim:name varchar
) WITH (
    type ='hbase',
    zookeeperQuorum ='127.0.0.1:2181',
    tableName ='test_dim',
    zookeeperParent ='/hbase',
    partitionedJoin ='false',
    rowKey ='id+channel',
    parallelism ='1'
);

insert into sink_test_console
select id, channel, name
from source_test
;

insert into sink_test_hbase
select id, channel, name
from source_test
;
