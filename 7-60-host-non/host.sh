if [ -n "$(docker container ls -f name=udemy-demo -q)" ]; then
    docker container rm -f $(docker container ls -f name=udemy-demo -q)
fi
# 设置network为host
docker container run --name udemy-demo -d --network host nginx 

docker container ls -f name=udemy-demo

# docker container exec -it udemy-demo ifconfig
    # 本来想用上边的命令来查看一下容器内的网络设定，发现nginx这个镜像居然没装net-tools，没法执行ifconfig
    # 想要看的话还得进去自己装 apt install net-tools 即可
    
# 在容器内使用ip查看当前的网络设定.会发现容器和host机器的网路完全一致
# 即容器内的所有端口直接映射到了本机的所有端口

# 好处
    # 方便直接
    # 理论上,使用bridge网络设定端口转发有一定的资源消耗,直接使用host网络性能更好

curl http://localhost

# 注意
    # 如果在host中运行多个容器,则需要注意端口占用的情况,
    # 如果出现抢占则会出现启动失败的情况
docker container run --network host --name udemy-demo-2 -d nginx 
docker container ls -a udemy-demo-2
docker logs -f udemy-demo-2


