```text
安装部署 http://www.dlink.top/docs/build_deploy/deploy


```

```sql
CREATE TABLE kafka_table
(
    `user_id` BIGINT,
    `name`    STRING
) WITH (
  'connector' = 'kafka',
  'topic' = 'test',
  'properties.bootstrap.servers' = '127.0.0.1:9092',
  'properties.group.id' = 'test',
  'scan.startup.mode' = 'latest-offset',
  'format' = 'csv'
);

CREATE TABLE print_table
(
    `user_id` BIGINT,
    `name`    STRING
) WITH (
  'connector' = 'print'
);

insert into print_table
select user_id, name
from kafka_table;

-- {"user_id":1,"user_name":"jack"}
-- {"user_id":1,"user_name":"tom"}
-- {"user_id":1,"user_name":"jack"}
```



```text
files:
dlink-flink1.4
<!-- https://mvnrepository.com/artifact/org.apache.flink/flink-json -->
        <dependency>
            <groupId>org.apache.flink</groupId>
            <artifactId>flink-json</artifactId>
            <version>${flink.version}</version>
        </dependency>

dlink-executor
<dependency>
            <groupId>org.apache.flink</groupId>
            <artifactId>flink-shaded-guava</artifactId>
            <version>30.1.1-jre-15.0</version>
        </dependency>

```