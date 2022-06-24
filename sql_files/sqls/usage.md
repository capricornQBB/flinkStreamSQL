sh submit.sh \
-mode yarnPer \
-sql /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sql_files/watermark/test.sql \
-name test_per \
-localSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins \
-remoteSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins \
-flinkconf /Users/tanweiquan/envR/server/flink-1.10.1/conf \
-yarnconf /Users/tanweiquan/envR/server/hadoop-2.7.3/etc/hadoop \
-flinkJarPath /Users/tanweiquan/envR/server/flink-1.10.1/lib \
-pluginLoadMode shipfile \
-confProp {\"time.characteristic\":\"eventTime\"}

{"uid":"1","record_time":"1655216214000"}
{"uid":"2","record_time":"1655216601000"}

Field reference expression or alias on field expression expected.