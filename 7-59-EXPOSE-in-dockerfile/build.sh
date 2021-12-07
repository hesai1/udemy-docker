#!/bin/bash

docker build -f dockerfile-expose -t expose-demo .
docker build -f dockerfile-no-expose -t no-expose-demo .

docker image inspect expose-demo > expose-demo
docker image inspect no-expose-demo > no-expose-demo

diff expose-demo  no-expose-demo > image-diff

# 可以在结果中看到，添加了expose的dockerfile在build后
# config的部分会多一个设定
# <             "ExposedPorts": {
# <                 "5000/tcp": {}
# <             },
# 然而这个部分的设定，并不会在实际运行时起任何作用
# 实际上这个expose只是起一个参考文档的作用，让使用镜像可以知道在运行时应使用哪一个端口
    # 以后遇到不清楚到底应该用哪个端口，可以用inspect看看config的设定，比如
        # $ docker image inspect nginx:latest 
        # [
        #     ...
        #             "ExposedPorts": {
        #                 "80/tcp": {}
        #             },
        #     ...
        # ]
# 实际上的端口转发还是需要在run的时候使用-p或者-P参数

# 详情可以参考docker文档 https://docs.docker.com/engine/reference/builder/#expose
  # The EXPOSE instruction does not actually publish the port. 
  # It functions as a type of documentation between the person 
  # who builds the image and the person who runs the container, 
  # about which ports are intended to be published. 
  # To actually publish the port when running the container,
  # use the -p flag on docker run to publish and map one or more ports, 
  # or the -P flag to publish all exposed ports and map them to high-order ports.
