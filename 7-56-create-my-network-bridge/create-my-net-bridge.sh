
if [ -n "$(docker network ls -f name=my-bridge -q)" ]; then
    docker network rm $(docker network ls -f name=my-bridge -q)
fi

# 创建一个自己的bridge
docker network create -d bridge my-bridge
echo "------------------------------------------------------------"

docker network ls
echo "------------------------------------------------------------"
docker network inspect my-bridge
