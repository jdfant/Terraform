variable "helm_hostname" {
  default = "rancher.home.lan"
}

variable "helm_repository" {
  default = "https://releases.rancher.com/server-charts/latest"
}

variable "helm_rancher_version" {
  default = "rancher-latest"
}

variable "private_ssh_key" {
  default = "./keys/rancho"
}

variable "cluster_tls_cert" {
  default = "./new_certs/cert.pem"
}

variable "cluster_tls_key" {
  default = "./new_certs/key.pem"
}

variable "cluster_ca_cert" {
  default = "./new_certs/cacert.pem"
}

variable "tls_cert" {
  default = "./certs/cert.pem"
}

variable "tls_key" {
  default = "./certs/key.pem"
}

variable "ca_cert" {
  default = "./certs/cacert.pem"
}

variable "rke_log" {
  default = "./rke.log"
}

variable "users" {
  type    = list
  default = ["root", "rancher", "jd"]
}

variable "node_ip" {
    default = ["192.168.100.60","192.168.100.61","192.168.100.62"]
}
