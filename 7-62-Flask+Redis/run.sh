# prepare image
docker image pull redis
docker image build -f dockerfile-flask -t flask-demo .

# create network
docker network create -d bridge demo-network

# create container
docker container run -d --name redis-server --network demo-network redis
docker container run -d --network demo-network --name flask-demo --env REDIS_HOST=redis-server -p 5000:5000 flask-demo


# BTW，有兴趣可以进到redis的容器内用cli查看，命令为redis-cli，比如下边
# docker container exec -it redis-server redis-cli