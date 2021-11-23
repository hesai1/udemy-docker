#!/bin/bash
dockerfilename=${1:-'dockerfile'}

docker build -f ${dockerfilename} -t udemy-class:tmp .
docker container rm -f $(docker container ls -f name=udemy-demo -q)
docker run --rm --name udemy-demo udemy-class:tmp world