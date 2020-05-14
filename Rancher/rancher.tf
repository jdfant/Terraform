provider "kubernetes" {}

resource "kubernetes_namespace" "cattle-system" {
  depends_on = [local_file.kube_cluster_yaml]
  metadata {
    annotations = {
      name = "cattle-system"
    }

    labels = {
      mylabel = "cattle-system"
    }

    name = "cattle-system"
  }
}

resource "kubernetes_secret" "tls-rancher-ingress" {
  depends_on = [kubernetes_namespace.cattle-system]
  metadata {
    name = "tls-rancher-ingress"
    namespace = "cattle-system"
      }

  data = {
      "tls.crt" = var.tls_cert
      "tls.key" = var.tls_key
  }

  type = "kubernetes.io/tls"
}

resource "kubernetes_secret" "tls-ca" {
  depends_on = [kubernetes_secret.tls-rancher-ingress]
  metadata {
    name = "tls-ca"
    namespace = "cattle-system"
      }

  data = {
      "ca.crt"  = var.ca_cert
  }

  type = "kubernetes.io/generic"
  }

provider "helm" {
  kubernetes {
    config_path = "./kube_config_cluster.yml"
  }
}

resource "helm_release" "rancher" {
  depends_on = [kubernetes_secret.tls-ca]
  name       = "rancher-latest"
  repository = "https://releases.rancher.com/server-charts/latest"
  chart      = "rancher"
  namespace  = "cattle-system"

  set {
    name  = "hostname"
    value = "var.helm_hostname"
  }

  set {
    name  = "ingress.tls.source"
    value = "secret"
  }

  set {
    name  = "tls"
    value = "external"
  }
  }
