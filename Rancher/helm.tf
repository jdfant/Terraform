resource "helm_release" "rancher" {
  depends_on = [kubernetes_secret.tls-ca]
  name       = var.helm_rancher_version
  repository = var.helm_repository
  chart      = "rancher"
  namespace  = "cattle-system"

  values = [
    file("values.yaml")
  ]

  set {
    name  = "privateCA"
    type  = "auto"
    value = true
  }
}
