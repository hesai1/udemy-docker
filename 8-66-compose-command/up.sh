# build镜像,redis直接拉取官方版本
docker image build -f flask-demo.dockerfile -t flask-demo:latest .
docker image pull redis:latest

# 关于启动docker-compose
# 最简单的的，直接
# docker-compose up
# 和 dockerfile 类似，
#     默认读取文件docker-compose.yml
#     如果文件名比较特殊，使用-f参数即可
# 也和 docker run 类似，
#     执行的 log 会直接输出到当前的标准输出中
#     linux系按ctrl-C还会直接kill掉所有container
#     在 up 的后边带上 -d 参数，可以后台运行
docker-compose up -d 

# 关于project名
#     启动的资源
#         包括network，volume，container的名字
#         都在compose文件中的名字前加了project的前缀
#         container的后边还会有一个数字编号的后缀
#             之后在容器的scale时候还会用到
#     project的名字
#         默认为当前的文件夹名
#         也可以在 docker-compose up 时加上 -p 参数指定名字
#         但是这样之后的所有命令都需手动带上 -p [project名]，很是有点麻烦
#             如 docker-compose stop -p  [project名]
#                docker-compose rm -p  [project名]
#         如果在 docker-compose.yml 的文件中指定了容器名，则会使用指定的名字
#             但这样会影响容器的scale，使用前还需考虑


# 查看当前的compose的容器
docker-compose ps
