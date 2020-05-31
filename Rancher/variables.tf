/*
 * RKE
 */

variable "rke_log" {
  default = "./rke.log"
}

variable "node_ip" {
  default = ["192.168.100.60", "192.168.100.61", "192.168.100.62"]
}

/*
 * Helm
 */

variable "helm_hostname" {
  default = "rancher.home.lan"
}

variable "helm_repository" {
  default = "https://releases.rancher.com/server-charts/latest"
}

variable "helm_rancher_version" {
  default = "rancher-latest"
}

/*
 * Certs/Keys
 */

variable "private_ssh_key" {
  default = "./keys/rancho"
}

variable "cluster_tls_cert" {
  default = "./kube_certs/cert.pem"
}

variable "cluster_tls_key" {
  default = "./kube_certs/key.pem"
}

variable "cluster_ca_cert" {
  default = "./kube_certs/cacerts.pem"
}

variable "tls_cert" {
  default = "./certs/cert.pem"
}

variable "tls_key" {
  default = "./certs/key.pem"
}

variable "ca_cert" {
  default = "./certs/cacerts.pem"
}

/*
 * System
 */

variable "users" {
  type    = list
  default = ["root", "rancher", "jd"]
}
