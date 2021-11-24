#!/bin/bash
dockerfilename=${1:-'dockerfile'}

docker build -f ${dockerfilename} -t udemy-class:tmp .
if [ -n "$(docker container ls -f name=udemy-demo -q)" ]; then
    docker container rm -f $(docker container ls -f name=udemy-demo -q)
fi
docker run -d -v tmp:/app --name udemy-demo udemy-class:tmp