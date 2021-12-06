if [ -n "$(docker container ls -f name=udemy-demo -q)" ]; then
    docker container rm -f $(docker container ls -f name=udemy-demo -q)
fi
# run的时候直接把当前目录mont到container里
docker run -d -v $(pwd):/app --name udemy-demo udemy-class:tmp
