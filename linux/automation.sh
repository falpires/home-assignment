#! /bin/bash
set -e

echo "Building the dockerize dockerfile"
docker build -t dockerize -f ../dockerize/Dockerfile ../dockerize

CURRENT_EPOCH=`date +%s` # Using epoch to tag images. Thought using semver or other sequential aproaches would be over engineering this
echo "Tagging docker image with $CURRENT_EPOCH"
docker tag dockerize dockerize:$CURRENT_EPOCH

echo "Replacing MY_NEW_IMAGE with dockerize:$CURRENT_EPOCH"
sed "s/MY_NEW_IMAGE/dockerize:$CURRENT_EPOCH/g" ./script.yaml > ./new-app.yaml

printf "Comparing new-app.yaml to actual state on minikube:\n\n\n\n"
kubectl diff -f ./new-app.yaml
