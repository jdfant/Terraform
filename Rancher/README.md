### Creates a 3 node RKE Kubernetes cluster (with 3 ETC services) on bare metal, then adds Rancher from Helm3 chart. ###

#### This is just a POC. NOT production ready ####

#### Kubernetes-Helm-Rancher graph: ####
![Kubernetes-Helm-Rancher_graph](images/kube-helm-rancher_graph.png)

**Still to do:**
- _Helm3 provider is still a bit flaky, may need to switch Rancher2 provider, for now :(_
- _Create additional Rancher/Kubernetes clusters._
- _Build, configure, populate external Docker registry._
- _Add CI/CD containers._
- _Add RancherOS (k3os??) installer?_
- _Create an Ansible wrapper for this to easily integrate https://github.com/jdfant/Ansible/tree/master/roles/lb for configuring external load balancers?_
