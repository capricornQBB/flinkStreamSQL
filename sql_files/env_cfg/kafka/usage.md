```shell
export KAFKA_HOME=/Users/tanweiquan/envR/server/kafka_2.11-0.11.0.3
export PATH=$KAFKA_HOME/bin:$PATH

kafka-server-start.sh ~/envR/server/kafka_2.11-0.11.0.3/config/server.properties
./bin/cmak -Dhttp.port=8081
kafka-topics.sh --create --topic test --replication-factor 1 --partitions 1 --zookeeper 127.0.0.1:2181
kafka-console-producer.sh --broker-list 127.0.0.1:9092 --topic test
kafka-console-consumer.sh --bootstrap-server 127.0.0.1:9092 --topic test --from-beginning
```