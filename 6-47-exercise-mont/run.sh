if [ -n "$(docker container ls -f name=udemy-demo -q)" ]; then
    docker container rm -f $(docker container ls -f name=udemy-demo -q)
fi
# 运行gcc的镜像，并将本地的文件映射到
docker container run -v $(pwd):/root --name udemy-demo -it gcc:9.4 bash

# 这样可以极大的方便我们进行一些学习或者开发工作
# 可以用docker的环境我们本地的代码进行编译，甚至运行

# 还有一种更简单的方法，直接使用vscode的remote Develop功能
    # 这个功能实质上就是在本地电脑上启动了一个container，
    # 并将指定的文件夹mont到container里，便可以对代码进行各种各样的操作
    # 参考https://www.udemy.com/course/docker-china/learn/lecture/27236572#content