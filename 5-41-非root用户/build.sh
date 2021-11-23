#!/bin/bash
dockerfilename=${1:-'dockerfile'}

docker build -f ${dockerfilename} -t udemy-class:tmp .
docker container rm -f $(docker container ls -f name=udemy-demo -q)
docker run -d  --name udemy-demo -p 5000:5000 udemy-class:tmpto