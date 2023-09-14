#!/bin/bash

K8S_NS='toolong'
kubectl create ns ${K8S_NS}

kubectl apply -f k8s/postgres.yaml -n ${K8S_NS}
kubectl apply -f k8s/backend.yaml -n ${K8S_NS}
kubectl apply -f k8s/frontend.yaml -n ${K8S_NS}
