# busybox 3
if [ -n "$(docker container ls -f name=box4 -q)" ]; then
    docker container rm -f $(docker container ls -f name=box4 -q)
fi
# 运行时添加参数network来指定使用的bridge
docker container run -d --rm --name box4 --network my-bridge busybox /bin/sh -c "while true; do sleep 3600; done"

docker container ls

docker network inspect my-bridge