FROM ubuntu:21.04
# 容器启动时默认执行的命令
    # 实际上ubuntu的镜像中已经默认了一个CMD，执行/bash
        # $ docker image history de
        # IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
        # de6f83bfe0b6        6 weeks ago         /bin/sh -c #(nop)  CMD ["bash"]                 0B
        # <missing>           6 weeks ago         /bin/sh -c #(nop) ADD file:3a18768000089a105…   80MB
    # 如果直接docker run -it [image name]的话不写sh也会自动执行bash
        

# 如果docker container run启动容器时指定了其它命令，则CMD命令会被忽略
    # 比如执行docker run -it [image name] whoami，则只会在命令行显示root，
    # 由于手动指定了whoami命令，将忽略原先的CMD，进而而不会进入container的bas

# 如果定义了多个CMD，只有最后一个会被执行。
    # 如在此文件中加入如下,则只会执行whoami，覆盖掉ubuntu原有的bash
    # CMD ["whoami"]
    # 甚至可以什么也不写，docker run时甚至会提醒你没有指定命令而无法执行
    # CMD []


