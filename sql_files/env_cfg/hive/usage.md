```shell
#hive
HIVE_HOME=/Users/tanweiquan/envR/server/apache-hive-2.3.8-bin
PATH=$HIVE_HOME/bin:$PATH

./schematool -initSchema -dbType  mysql

nohup hive --service metastore 2> /Users/tanweiquan/envR/server/tmp/hive/service_logs/metastore.log &
nohup hive --service metastore > /Users/tanweiquan/envR/server/tmp/hive/service_logs/metastore.log &
nohup hive --service metastore &

nohup hiveserver2 2> /Users/tanweiquan/envR/server/tmp/hive/service_logs/hiveserver.log &
nohup hiveserver2 > /Users/tanweiquan/envR/server/tmp/hive/service_logs/hiveserver.log
nohup hiveserver2 &

beeline -u jdbc:hive2://127.0.0.1:10000 -n root
!connect jdbc:hive2://127.0.0.1:10000
```

```hiveqlc
create table if not exists test.t_user
(
    id   int,
    name string
)
    partitioned by (dt string )
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    stored as textfile
;

insert into table t_user partition (dt = '20220601') (id, name)
values (1, 'tom'),
       (2, 'jack');
```