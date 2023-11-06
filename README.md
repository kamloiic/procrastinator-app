# TooLong 

## Overview 

TooLong is an Application that helps to save different links to review them later. It includes 2 components:

- `backend` is a service managing links (Go) 
- `frontend` is a frontend of the application (React)

![Ui](images/ui.png)

All the services are built into Docker images. They have been deployed in a Kubernetes Cluster following the pattern:

![Architecture](images/arch.png)

Ingress <--> Service <--> Deployment <--> {Secrets}

![Kubernetes Resources](images/arch-k8s.png)

All the procedure has been tested using 
- [Tanzu Kubernetes Grid](https://tanzu.vmware.com/kubernetes-grid) (TKG)
- [Contour](https://projectcontour.io)

## Setup the infrastructure

### New Tanzu Kubernetes Cluster

Create a new TKG cluster using the Supervisor cluster and the vSphere with Tanzu namespace.

This command will also install [Contour](https://projectcontour.io) in the TKG cluster.

Edit ```k8s/new-tkg-cluster.yaml``` and set the values for
- SC_IP 
- NAMESPACE

```
./k8s/new-tkg-cluster.sh 
```







