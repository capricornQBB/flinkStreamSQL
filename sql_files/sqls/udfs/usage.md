```shell

sh submit.sh \
  -mode yarnPer \
  -sql /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sql_files/sqls/udfs/test.sql \
  -name test_per \
  -localSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins \
  -remoteSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins \
  -flinkconf /Users/tanweiquan/envR/server/flink-1.10.1/conf \
  -yarnconf /Users/tanweiquan/envR/server/hadoop-2.7.3/etc/hadoop \
  -flinkJarPath /Users/tanweiquan/envR/server/flink-1.10.1/lib \
  -addjar "[\"/Users/tanweiquan/codeR/own_git/flinkStreamSQL/sql_files/sqls/udfs/flink_udf-1.0.1.jar\"]" \
  -pluginLoadMode shipfile
  
  
  
```
{"uid":"1","email":"tom@com"}
{"uid":"2","email":"jack@com"}
{"uid":"1","email":"tom2@com"}
