```shell
export FLINK_HOME=/Users/tanweiquan/envR/server/flink-1.10.1
export PATH=$FLINK_HOME/bin:$PATH

export HADOOP_CLASSPATH=`hadoop classpath`
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


flink run -m yarn-cluster -c cn.inke.FraudDetectionJob /Users/tanweiquan/codeR/intelliJ/flink_dev/target/flink_dev-0.1.jar
flink run -m yarn-cluster -c cn.inke.FraudDetectionJob /a8root/work/tmp_twq/git/flink_inke_gz/demo/flink_dev-0.1.jar
```