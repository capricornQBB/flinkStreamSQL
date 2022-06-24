#### version

- icerberg=0.13.2
- flink-cdc=2.2
- flink=1.14.5

#### flink-sql

https://ververica.github.io/flink-cdc-connectors/master/content/%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B/build-real-time-data-lake-tutorial-zh.html

```shell
./bin/sql-client.sh embedded \
    -j lib/iceberg-flink-runtime-1.14-0.13.2.jar 
```

```sql
-- cdc
CREATE TABLE products
(
    database_name STRING,
    table_name    STRING,
    id            INT,
    name          STRING,
    description   STRING,
    PRIMARY KEY (id) NOT ENFORCED
) WITH (
     'connector' = 'mysql-cdc',
     'hostname' = '127.0.0.1',
     'port' = '3306',
     'username' = 'root',
     'password' = 'root',
     'database-name' = 'dev',
     'table-name' = 'products'
   );

select count(1)
from products;

-- iceberg
CREATE TABLE products_sink
(
    database_name STRING,
    table_name    STRING,
    `id`          bigint,
    name          STRING,
    description   STRING,
    PRIMARY KEY (id) NOT ENFORCED
) WITH (
    'connector'='iceberg',
    'catalog-name'='hadoop_catalog',
    'catalog-type'='hadoop',  
    'warehouse'='hdfs://127.0.0.1:9000/iceberg/warehouse/',
    'format-version'='1'
  );


CREATE
CATALOG hadoop_catalog
WITH (
    'type'='iceberg',
    'catalog-type'='hadoop',
    'warehouse'='hdfs://127.0.0.1:9000/iceberg/warehouse/',
    'property-version'='1'
);

CREATE TABLE `hadoop_catalog`.`default_database`.`products_sink`
(
    database_name STRING,
    table_name    STRING,
    `id`          bigint,
    name          STRING,
    description   STRING
) ;
```
