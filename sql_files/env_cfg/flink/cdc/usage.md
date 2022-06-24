```sql
-- CREATE TABLE user_source
-- (
--     database_name STRING METADATA VIRTUAL,
--     table_name    STRING METADATA VIRTUAL,
--     `id`          DECIMAL(20, 0) NOT NULL,
--     name          STRING,
--     address       STRING,
--     phone_number  STRING,
--     email         STRING,
--     PRIMARY KEY (`id`) NOT ENFORCED
-- ) WITH (
-- 'connector' = 'mysql-cdc',
-- 'hostname' = '127.0.0.1',
-- 'port' = '3306',
-- 'username' = 'root',
-- 'password' = 'root',
-- 'database-name' = 'db_[0-9]+',
-- 'table-name' = 'user_[0-9]+'
-- );

CREATE TABLE print_table
(
    database_name STRING,
    table_name    STRING,
    `id`          DECIMAL(20, 0) NOT NULL,
    name          STRING,
    address       STRING,
    phone_number  STRING,
    email         STRING,
    PRIMARY KEY (`id`) NOT ENFORCED
) WITH (
  'connector' = 'print'
);

INSERT INTO print_table
select *
from user_source;


CREATE TABLE products
(
    id          INT,
    name        STRING,
    description STRING,
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
```