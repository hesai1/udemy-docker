# busybox 1
if [ -n "$(docker container ls -f name=box1 -q)" ]; then
    docker container rm -f $(docker container ls -f name=box1 -q)
fi
docker container run -d --rm --name box1 busybox /bin/sh -c "while true; do sleep 3600; done"

# busybox 2
if [ -n "$(docker container ls -f name=box2 -q)" ]; then
    docker container rm -f $(docker container ls -f name=box2 -q)
fi
docker container run -d --rm --name box2 busybox /bin/sh -c "while true; do sleep 3600; done"


docker container ls
# 不做设定的话会直接使用默认的bridge。
    # $ docker network ls
    # NETWORK ID     NAME        DRIVER    SCOPE
    # c952c899abca   bridge      bridge    local    ->  默认的bridge，名字就叫bridge
    # 778d62a8fce7   host        host      local
    # ea83a00381cf   minikube    bridge    local
    # f324b12bd74f   my-bridge   bridge    local
    # 594694aab4e3   none        null      local
 
# 查看默认bridge的详细设定可以发现box1，box2的设定
    # docker network inspect bridge
        #  .......
        #  "Containers": {
        #     "af7702b7255d33fb561d84343f109dc42f7115245e6a2a13a99e67393e62cf0a": {
        #         "Name": "box2",
        #         "EndpointID": "03a986491a333a468ffc50d3fc1a501b77ceeea9ed709b7622f930671b56ca7b",
        #         "MacAddress": "02:42:ac:11:00:04",
        #         "IPv4Address": "172.17.0.4/16",
        #         "IPv6Address": ""
        #     },
        #     "dd281683b7a94db3fcf721c38b48667febb09f269ef6112cd68dfc95e5ba6286": {
        #         "Name": "box1",
        #         "EndpointID": "da5800984a5719f256a773ab24404f49cffb453ddbe9001a218b70a2d0d8410c",
        #         "MacAddress": "02:42:ac:11:00:03",
        #         "IPv4Address": "172.17.0.3/16",
        #         "IPv6Address": ""
        #     }
        # },
        #  .......