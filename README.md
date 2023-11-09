# TooLong 

## Overview 

TooLong is an Application that helps to save different links to review them later. It includes 2 components:

- `backend` is a service managing links (Go) 
- `frontend` is a frontend of the application (React)

![Ui](images/ui.png)

All the services are built into Docker images. They have been deployed in a Kubernetes Cluster following the pattern:

![Architecture](images/arch.png)

All the procedure has been tested on Windows (and Mac) using
- Docker  
- [Tanzu Kubernetes Grid](https://tanzu.vmware.com/kubernetes-grid) (vSphere with Tanzu)
- [Contour](https://projectcontour.io)
- Helm


## Setup the infrastructure

### New Tanzu Kubernetes Cluster

Create a new TKG cluster using the Supervisor cluster and the vSphere with Tanzu namespace.


Edit ```k8s/new-tkg-cluster.yaml``` and set the values for
- SC_IP 
- NAMESPACE

```
./k8s/new-tkg-cluster.sh 
```

This command will also install [Contour](https://projectcontour.io) in the TKG cluster.

Record the external IP of the envoy service deployed previously
```
kubectl get svc -n projectcontour
...
NAME      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)                      AGE
contour   ClusterIP      10.104.172.208   <none>         8001/TCP                     7d2h
envoy     LoadBalancer   10.108.0.184     172.16.110.7   80:31880/TCP,443:31564/TCP   7d2h
```

### Setup Harbor Registry 




### Cloud Native Buildpacks using kPack

Build containers using [Cloud Native Buildpacks](https://buildpacks.io/)(CNB) instead of writting ```Dockerfile```. 

Install kPack
```
kubectl apply -f https://github.com/buildpacks-community/kpack/releases/download/v0.11.3/release-0.11.3.yaml
```



## Deployments 

Deploy the Kubernetes ressources with this command
```
export K8S_NS='default'
kubectl apply -f k8s/postgres.yaml -n ${K8S_NS}
kubectl apply -f k8s/backend.yaml -n ${K8S_NS}
kubectl apply -f k8s/frontend.yaml -n ${K8S_NS}
```

Edit the /etc/hosts file
```
172.16.110.7 frontend.172.16.110.7.nip.io
172.16.110.7 backend.172.16.110.7.nip.io
```

Open the website using the link ```http://frontend.172.16.110.7.nip.io/```























