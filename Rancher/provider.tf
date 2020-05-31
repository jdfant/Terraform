provider "rke" {
  log_file = var.rke_log
}

provider "kubernetes" {
  host     = rke_cluster.cluster.api_server_url
  username = rke_cluster.cluster.kube_admin_user

  client_certificate     = rke_cluster.cluster.client_cert
  client_key             = rke_cluster.cluster.client_key
  cluster_ca_certificate = rke_cluster.cluster.ca_crt
}

provider "helm" {
  kubernetes {
    config_path = "./kube_config_cluster.yml"
    #host     = rke_cluster.cluster.api_server_url
    #username = rke_cluster.cluster.kube_admin_user

    #client_certificate     = rke_cluster.cluster.client_cert
    #client_key             = rke_cluster.cluster.client_key
    #cluster_ca_certificate = rke_cluster.cluster.ca_crt
  }
}
