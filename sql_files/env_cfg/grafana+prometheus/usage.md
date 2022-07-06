```shell
brew install grafana
brea install prometheus

brew services restart grafana
brew services restart prometheus

#http://127.0.0.1:3000/
#http://127.0.0.1:9090/

./kafka_exporter --kafka.server=127.0.0.1:9092 --kafka.version=0.11.0.3
```