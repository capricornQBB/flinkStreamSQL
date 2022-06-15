```shell
docker run --name clickhouse-server \
-p 8123:8123 \
-p 9009:9009 \
-p 9000:9000 \
--ulimit nofile=262144:262144 \
-v /Users/tanweiquan/envR/dockerR/clickhouse:/var/lib/clickhouse \
-d yandex/clickhouse-server
```