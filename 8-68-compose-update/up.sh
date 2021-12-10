# 基本的结构和上一节一样


docker-compose up -d 
# 执行结果
#  ...（build省略）...
# Creating network "8-68-compose-update_demo-network" with the default driver
# Creating 8-68-compose-update_redis-server_1 ... done
# Creating 8-68-compose-update_flask-demo_1   ... done

docker container ls
# 执行结果
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS                    NAMES
# 8f1cbdc2a1b9   redis:latest        "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes   6379/tcp                 8-68-compose-update_redis-server_1
# 421c676743e8   flask-demo:latest   "flask run -h 0.0.0.0"   3 minutes ago   Up 3 minutes   0.0.0.0:8080->5000/tcp   8-68-compose-update_flask-demo_1


echo "------------------------------------------"

# 如果这时停止再重新启动
docker-compose stop
# Stopping 8-68-compose-update_redis-server_1 ... done
# Stopping 8-68-compose-update_flask-demo_1   ... done

docker-compose up -d
# Starting 8-68-compose-update_redis-server_1 ... done
# Starting 8-68-compose-update_flask-demo_1   ... done

docker container ls
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS           PORTS                    NAMES
# 8f1cbdc2a1b9   redis:latest        "docker-entrypoint.s…"   6 minutes ago   Up 30 seconds    6379/tcp                 8-68-compose-update_redis-server_1
# 421c676743e8   flask-demo:latest   "flask run -h 0.0.0.0"   6 minutes ago   Up 30 seconds    0.0.0.0:8080->5000/tcp   8-68-compose-update_flask-demo_1

# 可以发现镜像没有重新构建，而是直接使用了本地的现有镜像

echo "------------------------------------------"

# 如果想更新镜像，当然也可以手动执行构建
# docker-compose build 
# 还有一种方法，再up的时候添加--build参数,便会对文件中设定有build的镜像的部分从新构建
    # 本例中会重新打包
docker-compose up -d --build
# Building flask-demo
# [+] Building 3.0s (10/10) FINISHED
#  => [internal] load build definition from flask-demo.dockerfile                              0.0s 
#  => => transferring dockerfile: 377B                                                         0.0s 
#  => [internal] load .dockerignore                                                            0.0s 
#  => => transferring context: 2B                                                              0.0s 
#  => [internal] load metadata for docker.io/library/python:3.9.5-slim                         2.8s 
#  => [auth] library/python:pull token for registry-1.docker.io                                0.0s 
#  => [1/4] FROM docker.io/library/python:3.9.5-slim@sha256:9828573e6a0b02b6d0ff0bae0716b027a  0.0s
#  => [internal] load build context                                                            0.0s 
#  => => transferring context: 418B                                                            0.0s 
#  => CACHED [2/4] RUN pip install flask redis &&     groupadd -r flask && useradd -r -g flas  0.0s
#  => CACHED [3/4] COPY app.py /src/app.py                                                     0.0s 
#  => CACHED [4/4] WORKDIR /src                                                                0.0s 
#  => exporting to image                                                                       0.0s 
#  => => exporting layers                                                                      0.0s 
#  => => writing image sha256:3929cc35343fd81ea3ea084fbcec47e6f26906cd78a09dfa4c47a71c2fe58fe  0.0s 
#  => => naming to docker.io/library/flask-demo:latest                                         0.0s 
# 8-68-compose-update_redis-server_1 is up-to-date
# 8-68-compose-update_flask-demo_1 is up-to-date
docker container ls
# CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS         PORTS                    NAMES
# 8f1cbdc2a1b9   redis:latest        "docker-entrypoint.s…"   14 minutes ago   Up 8 minutes   6379/tcp                 8-68-compose-update_redis-server_1
# 421c676743e8   flask-demo:latest   "flask run -h 0.0.0.0"   14 minutes ago   Up 8 minutes   0.0.0.0:8080->5000/tcp   8-68-compose-update_flask-demo_1

# 注意这里两个服务是up-tp-date。
# 后来检测执行的容器，还跟之前的id一样，
# 说明并没有对容器进行更新

# 因为镜像的构建结果相同，所以会直接流用之前的容器

echo "------------------------------------------"

# 如果对build使用的文件等进行一些修改，则会再build完之后，就会recreate镜像
echo "# test at $(date)" >> ./flask/app.py  

docker-compose up -d --build
# Building flask-demo
# [+] Building 3.0s (10/10) FINISHED
#  => [internal] load build definition from flask-demo.dockerfile                              0.0s 
#  => => transferring dockerfile: 49B                                                          0.0s 
#  => [internal] load .dockerignore                                                            0.0s 
#  => => transferring context: 2B                                                              0.0s 
#  => [internal] load metadata for docker.io/library/python:3.9.5-slim                         2.8s 
#  => [auth] library/python:pull token for registry-1.docker.io                                0.0s 
#  => [1/4] FROM docker.io/library/python:3.9.5-slim@sha256:9828573e6a0b02b6d0ff0bae0716b027a  0.0s 
#  => [internal] load build context                                                            0.0s 
#  => => transferring context: 450B                                                            0.0s 
#  => CACHED [2/4] RUN pip install flask redis &&     groupadd -r flask && useradd -r -g flas  0.0s 
#  => [3/4] COPY app.py /src/app.py                                                            0.0s 
#  => [4/4] WORKDIR /src                                                                       0.0s 
#  => exporting to image                                                                       0.1s 
#  => => exporting layers                                                                      0.1s 
#  => => writing image sha256:7e4acd627580d902487c06f76c4af15bf3e27ad29ee57200bfe1f353c017e45  0.0s 
#  => => naming to docker.io/library/flask-demo:latest                                         0.0s 
# 8-68-compose-update_redis-server_1 is up-to-date
# Recreating 8-68-compose-update_flask-demo_1 ... done

# 可以看到，直接使用官方镜像的redis服务已经up-to-date
# 自己build的flask服务再重新构建镜像之后发现更新开始recreate

docker container ls
# CONTAINER ID   IMAGE               COMMAND                  CREATED              STATUS   PORTS                    NAMES
# 860bf9fc3e62   flask-demo:latest   "flask run -h 0.0.0.0"   About a minute ago   Up About a minute   0.0.0.0:8080->5000/tcp   8-68-compose-update_flask-demo_1
# 8f1cbdc2a1b9   redis:latest        "docker-entrypoint.s…"   32 minutes ago       Up 25 minutes       6379/tcp                 8-68-compose-update_redis-server_1

# 容器一览，flask服务已经启动新的容器id不同
# redis还是使用之前的镜像，id和之前也就相同

# 其实还有两个可以参考参数 --no-recreate 和 --force-recreate
# force : 强制重构所有的容器
# no : 就算镜像有变更，如果该服务当前有容器执行，则不对其更新

# ----------------
# 以上都是关于镜像的
# ----------------

# compose文件本身发生更新时
# 如果是增加模块
diff docker-compose.yml docker-compose-add.yml 
# 18a19,24
# >   buzy-box:
# >     image: busybox:latest
# >     networks:
# >       - demo-network
# >     command:
# >       /bin/sh -c "while true; do sleep 3600; done"

docker-compose -f docker-compose-add.yml up -d   
# 8-68-compose-update_redis-server_1 is up-to-date
# 8-68-compose-update_flask-demo_1 is up-to-date
# Creating 8-68-compose-update_buzy-box_1 ... done
docker container ls
# CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                    NAMES
# 6a0640dd7b82   busybox:latest      "/bin/sh -c 'while t…"   2 minutes ago    Up 2 minutes                    8-68-compose-update_buzy-box_1
# 860bf9fc3e62   flask-demo:latest   "flask run -h 0.0.0.0"   12 minutes ago   Up 12 minutes   0.0.0.0:8080->5000/tcp   8-68-compose-update_flask-demo_1
# 8f1cbdc2a1b9   redis:latest        "docker-entrypoint.s…"   42 minutes ago   Up 36 minutes   6379/tcp                 8-68-compose-update_redis-server_1
# 已有不动，新增的create。

# 如果是减少
docker-compose -f docker-compose.yml up -d
# WARNING: Found orphan containers (8-68-compose-update_buzy-box_1) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans 
# flag to clean it up.
# 8-68-compose-update_flask-demo_1 is up-to-date
# 8-68-compose-update_redis-server_1 is up-to-date
docker container ls
# CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                    NAMES
# 6a0640dd7b82   busybox:latest      "/bin/sh -c 'while t…"   3 minutes ago    Up 3 minutes                    8-68-compose-update_buzy-box_1
# 860bf9fc3e62   flask-demo:latest   "flask run -h 0.0.0.0"   13 minutes ago   Up 13 minutes   0.0.0.0:8080->5000/tcp   8-68-compose-update_flask-demo_1
# 8f1cbdc2a1b9   redis:latest        "docker-entrypoint.s…"   43 minutes ago   Up 37 minutes   6379/tcp                 8-68-compose-update_redis-server_1

# 会有warning提示,默认是不会自动删除多余的容器的.
# 如果想自动删除掉不用的内容,可以使用--remove-orphans,就会自动删除不需要的服务

docker-compose up -d --remove-orphans
# Removing orphan container "8-68-compose-update_buzy-box_1"
# 8-68-compose-update_flask-demo_1 is up-to-date
# 8-68-compose-update_redis-server_1 is up-to-date
# 当然，这些操作并不会影响其他的容器，只会对当前的project起效

# 还有一种情况，容器通过volume读取设定文件的更新
# 这时候一般的做法是重启容器，可以执行
docker-compose restart
