#!/bin/bash

kubectl delete deployment.apps/backend-deployment -n ${K8S_NS}
kubectl delete deployment.apps/frontend-deployment -n ${K8S_NS}
kubectl delete deployment.apps/postgres-deployment -n ${K8S_NS}

kubectl delete service/frontend-deployment -n ${K8S_NS}
kubectl delete service/backend-deployment -n ${K8S_NS}
kubectl delete service/postgres-deployment -n ${K8S_NS}