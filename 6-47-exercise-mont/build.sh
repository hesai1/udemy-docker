#!/bin/bash
dockerfilename=${1:-'dockerfile'}

docker build -f ${dockerfilename} -t udemy-class:tmp .
