# 将box3也添加bridge中
docker network connect bridge box3

docker container inspect box3

# 想删除也很简单
# docker network disconnect bridge box3
