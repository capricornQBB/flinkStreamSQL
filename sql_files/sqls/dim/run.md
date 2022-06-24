```shell

#  -sql /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sql_files/dim/sink_hbase.sql \

sh submit.sh \
  -mode yarnPer \
  -sql /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sql_files/dim/dim_hbase.sql \
  -name test_per \
  -localSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins \
  -remoteSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins \
  -flinkconf /Users/tanweiquan/envR/server/flink-1.10.1/conf \
  -yarnconf /Users/tanweiquan/envR/server/hadoop-2.7.3/etc/hadoop \
  -flinkJarPath /Users/tanweiquan/envR/server/flink-1.10.1/lib \
  -pluginLoadMode shipfile
  
  
create 'test_dim', 'dim'
  
{"name":"jack","channel":"1","id":"1"}
{"name":"tom","channel":"2","id":"2"}
{"name":"vic","channel":"3","id":"3"}
{"name":"marry","channel":"1","id":"4"}
{"a":"aaaa","b":"bbb","c":"ccc","id":"11"}
```