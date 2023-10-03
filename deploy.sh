#!/bin/bash

K8S_NS='toolong'

#install contour ingress
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/contour --namespace contour --create-namespace
kubectl -n contour get po,svc

kubectl create ns ${K8S_NS}

kubectl apply -f k8s/postgres.yaml -n ${K8S_NS}
kubectl apply -f k8s/backend.yaml -n ${K8S_NS}
kubectl apply -f k8s/frontend.yaml -n ${K8S_NS}

