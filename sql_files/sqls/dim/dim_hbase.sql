create table source_test_kafka
(
    id varchar,
    a  varchar,
    b  varchar,
    c  varchar
)with(
     type ='kafka11',
     bootstrapservers ='127.0.0.1:9092',
     zookeeperquorum ='127.0.0.1:2181/kafka',
     offsetreset ='latest',
     topic ='test_dim',
     groupid='test_dim',
     parallelism ='1'
     );

create table sink_test_console
(
    id   varchar,
    a    varchar,
    b    varchar,
    c    varchar,
    name varchar
) with (
      type ='console',
      parallelism ='1'
);

CREATE TABLE side_test_hbase
(
    dim:id varchar as id,
    dim:channel varchar as channel,
    dim:name varchar as name,
    PRIMARY KEY (rowkey1),
    PERIOD FOR SYSTEM_TIME
) WITH (
        type = 'hbase',
        zookeeperQuorum = '127.0.0.1:2181',
        zookeeperParent = '/hbase',
        tableName = 'test_dim',
        parallelism = '1',
        cache = 'NONE',
        parallelism ='1',
        partitionedJoin='false'
);

insert into sink_test_console
select t1.id
     , t1.a
     , t1.b
     , t1.c
     , t2.name
from source_test_kafka t1
         left join side_test_hbase t2 on t1.id = t2.rowkey1
;
