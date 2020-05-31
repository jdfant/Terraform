resource "local_file" "ca_crt" {
  filename = var.cluster_ca_cert
  content  = rke_cluster.cluster.ca_crt
}

resource "local_file" "client_cert" {
  filename = var.cluster_tls_cert
  content  = rke_cluster.cluster.client_cert
}

resource "local_file" "client_key" {
  filename = var.cluster_tls_key
  content  = rke_cluster.cluster.client_key
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.cluster.kube_config_yaml

  provisioner "local-exec" {
    command = "cp kube_config_cluster.yml ~/.kube/config"
  }
}
