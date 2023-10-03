#!/bin/bash

IMAGE_NAME=too-long
IMAGE_VERSION=0.1
NAMESPACE=ns-toolong

docker login rg.fr-par.scw.cloud/ns-toolong -u nologin --password-stdin <<< "$SCW_SECRET_KEY"

cd backend
pack build ${IMAGE_NAME}-backend:${IMAGE_VERSION} --builder paketobuildpacks/builder:base
docker tag ${IMAGE_NAME}-backend[:${IMAGE_VERSION}] core.harbor.domain/too-long-app/REPOSITORY[:TAG]
# docker tag ${IMAGE_NAME}-backend:${IMAGE_VERSION} rg.fr-par.scw.cloud/ns-toolong/${IMAGE_NAME}-backend:${IMAGE_VERSION}
docker push rg.fr-par.scw.cloud/${NAMESPACE}/${IMAGE_NAME}-backend:${IMAGE_VERSION}

cd ../frontend
pack build ${IMAGE_NAME}-frontend:${IMAGE_VERSION} --builder paketobuildpacks/builder:base

docker tag ${IMAGE_NAME}-frontend:${IMAGE_VERSION} rg.fr-par.scw.cloud/${NAMESPACE}/${IMAGE_NAME}-frontend:${IMAGE_VERSION}
docker push rg.fr-par.scw.cloud/${NAMESPACE}/${IMAGE_NAME}-frontend:${IMAGE_VERSION}


