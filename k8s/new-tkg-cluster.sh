# https://github.com/vsphere-tmm/vsphere-with-tanzu-quick-start

export SC_IP=tanzu.demo.lab
export NAMESPACE=lkam-nms

# Login using kubectl
kubectl vsphere login --server $SC_IP --vsphere-username administrator@vsphere.local
kubectl vsphere login --server tanzu.demo.lab --vsphere-username administrator@vsphere.local --tanzu-kubernetes-cluster-namespace tkc-nms --tanzu-kubernetes-cluster-name tkc-1

#Set kubectl context to be the supervisor cluster
kubectl config use-context $NAMESPACE

#Deploy TKG Service cluster
kubectl apply -f tkc.yaml

#Watching the deployment via kubectl
kubectl describe tkc

#Login to TKG service cluster
kubectl vsphere login --server=$SC_IP --tanzu-kubernetes-cluster-name tkc-1 --tanzu-kubernetes-cluster-namespace $NAMESPACE --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify

#Use the TKG cluster context
kubectl config use-context tkc-1

#Install Contour 
kubectl apply -f https://projectcontour.io/quickstart/contour.yaml
kubectl get pods -n projectcontour -o wide
