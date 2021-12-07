if [ -n "$(docker container ls -f name=udemy-demo -q)" ]; then
    docker container rm -f $(docker container ls -f name=udemy-demo -q)
fi
# docker run的参数，-p [HostPort]:[ContainerPort]将本机host的端口映射给容器的端口
docker container run --name udemy-demo -p 8080:80 -d nginx 

# 本地访问 http://localhost:8080/
# 或者同一局域网内访问