```shell
./configure --prefix=/usr/local/protobuf
sudo make
sudo make check
sudo make install

export PB=/usr/local/protobuf
export PATH=$PB/bin:path
protoc --java_out=. ${filename}.proto
```