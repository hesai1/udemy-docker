# docker image build -f flask-demo.dockerfile -t flask-demo .
# 写好docker-compose.yml中的build设定就可以再像上边这样繁琐的构筑镜像

docker-compose build
# 这个命令会直接构筑docker-compose.yml中所有service需要的镜像
    # 当然redis的镜像我们本来就是拉取的所以不会构筑
# 或使用下边的方式指定需要构筑镜像的service
# docker-compose build flask-demo

# docker image pull redis:latest
# 镜像的拉取也一样。使用下边的命令会从远程拉取所有service需要的image
    # 注意时所有service，包括flask-demo
    # 因此会看到拉取镜像 flask-demo 失败
docker-compose pull

docker-compose up -d 

docker-compose ps
