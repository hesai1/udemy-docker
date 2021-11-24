#!/bin/bash

if [ -n "$(docker container ls -f name=udemy-demo -q)" ]; then
    docker container rm -f $(docker container ls -f name=udemy-demo -q)
fi
# 不用dockerfile了，直接整官方的mysql 5.7镜像
docker container run \
     --name udemy-demo \
     -e MYSQL_ROOT_PASSWORD=my-secret-pw \
     -d \
     -v mysql-data:/var/lib/mysql \
     mysql:5.7 