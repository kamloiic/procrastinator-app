#!/bin/bash

IMAGE_NAME=too-long
IMAGE_VERSION=0.1

cd backend
pack build ${IMAGE_NAME}-backend --builder paketobuildpacks/builder:base

docker tag ${IMAGE_NAME}-backend:latest docker.pkg.github.com/kamloiic/${IMAGE_NAME}/${IMAGE_NAME}-backend:${IMAGE_VERSION}
echo "${GHCR_TOKEN}" | docker login docker.pkg.github.com -u kamloiic --password-stdin
docker push docker.pkg.github.com/kamloiic/${IMAGE_NAME}/${IMAGE_NAME}-backend:${IMAGE_VERSION}

cd ../frontend
pack build ${IMAGE_NAME}-frontend --builder paketobuildpacks/builder:base

docker tag ${IMAGE_NAME}-frontend:latest docker.pkg.github.com/kamloiic/${IMAGE_NAME}/${IMAGE_NAME}-frontend:${IMAGE_VERSION}
docker push docker.pkg.github.com/kamloiic/${IMAGE_NAME}/${IMAGE_NAME}-frontend:${IMAGE_VERSION}
