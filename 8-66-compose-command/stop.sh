# 关闭的方式也很简单

docker-compose stop

    # 可以使用 -f 参数来指定使用的文件
    # 或者使用 -p 参数来用project名指定
# 留下的容器可以使用下边的命令来清里
# docker-compose rm 
# 但是这样并不会删除network的设定，所以也可以使用docker来清理垃圾

docker system prune -f
