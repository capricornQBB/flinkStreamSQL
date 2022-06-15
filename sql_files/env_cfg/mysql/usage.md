```shell
docker pull mysql
docker run \
-p 3306:3306 \
--name mysql \
-v /Users/tanweiquan/envR/dockerR/mysql/conf:/etc/mysql/conf.d \
-v /Users/tanweiquan/envR/dockerR/mysql/logs:/logs \
-v /Users/tanweiquan/envR/dockerR/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
-d mysql:oracle # ur docker image
```

[comment]: <> (TODO : mac install mysql)