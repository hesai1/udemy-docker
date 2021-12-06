# box3和box4都在同一个自定义的my-bridge中，可以用container的名字当host名直接ping通
docker container exec -it box3 ping box4

# 默认bridge不提供container名的dns服务，box1和2却不能用名字直接ping通
docker container exec -it box1 ping box2
