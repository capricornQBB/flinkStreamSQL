```shell
hadoop namenode –format

ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh localhost

curl http://localhost:50070/
curl http://localhost:8088/cluster

#hadoop
export HADOOP_HOME=/Users/tanweiquan/envR/server/hadoop-2.7.3
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"
export HADOOP_CLASSPATH=`hadoop classpath`
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
```