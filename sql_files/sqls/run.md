```shell
/Users/tanweiquan/codeR/own_git/flinkStreamSQL
sh submit.sh \
  -mode local \
  -sql /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sql_files/test.sql \
  -name test_standalone_flinkStreamSql \
  -localSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins

{"name":"jack","channel":"1"}
{"name":"tom","channel":"1"}
{"name":"vic","channel":"2"}
{"name":"marry","channel":"3"}

sh submit.sh \
  -mode yarnPer \
  -sql /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sql_files/test.sql \
  -name test_per \
  -localSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins \
  -remoteSqlPluginPath /Users/tanweiquan/codeR/own_git/flinkStreamSQL/sqlplugins \
  -flinkconf /Users/tanweiquan/envR/server/flink-1.10.1/conf \
  -yarnconf /Users/tanweiquan/envR/server/hadoop-2.7.3/etc/hadoop \
  -flinkJarPath /Users/tanweiquan/envR/server/flink-1.10.1/lib \
  -pluginLoadMode shipfile \
  -confProp {"time.characteristic":"eventTime"}
  -queue c
```


```shell
flink run -m yarn-cluster -c com.xxx.WordCount ./xxxx.jar
  -yn,--container <arg> 表示分配容器的数量，也就是 TaskManager 的数量。
  -d,--detached：设置在后台运行。
  -yjm,--jobManagerMemory<arg>:设置 JobManager 的内存，单位是 MB。
  -ytm，--taskManagerMemory<arg>:设置每个 TaskManager 的内存，单位是 MB。
  -ynm,--name:给当前 Flink application 在 Yarn 上指定名称。
  -yq,--query：显示 yarn 中可用的资源（内存、cpu 核数）
  -yqu,--queue<arg> :指定 yarn 资源队列
  -ys,--slots<arg> :每个 TaskManager 使用的 Slot 数量。
  -yz,--zookeeperNamespace<arg>:针对 HA 模式在 Zookeeper 上创建 NameSpace
  -yid,--applicationID<yarnAppId> : 指定 Yarn 集群上的任务 ID,附着到一个后台独立运行的 Yarn Session 中。
  
#bin/flink run -t yarn-per-job -yjm 512 -ytm 512 -p 1 
./bin/flink run -m yarn-cluster -yjm 256 -ytm 256 -ys 1 -p 1 \
-c org.apache.flink.streaming.examples.socket.SocketWindowWordCount examples/batch/WordCount.jar \
./examples/batch/WordCount.jar \
--input hdfs:///..../LICENSE-2.0.txt --output hdfs:///.../wordcount-result.txt


bin/yarn-session.sh -n 1 -s 1 -nm test1
yarn-session.sh 参数说明如下：
  -n,--container <arg> 表示分配容器的数量（也就是 TaskManager 的数量）。
 -D <arg> 动态属性。
 -d,--detached 在后台独立运行。
 -jm,--jobManagerMemory <arg>：设置 JobManager 的内存，单位是 MB。
 -nm,--name：在 YARN 上为一个自定义的应用设置一个名字。
 -q,--query：显示 YARN 中可用的资源（内存、cpu 核数）。
 -qu,--queue <arg>：指定 YARN 队列。
 -s,--slots <arg>：每个 TaskManager 使用的 Slot 数量。
 -tm,--taskManagerMemory <arg>：每个 TaskManager 的内存，单位是 MB。
 -z,--zookeeperNamespace <arg>：针对 HA 模式在 ZooKeeper 上创建 NameSpace。
 -id,--applicationId <yarnAppId>：指定 YARN 集群上的任务 ID，附着到一个后台独立运行的 yarn session 中
```