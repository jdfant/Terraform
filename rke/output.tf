output "all_nodes" {
  description = "Show details for all nodes"
  value       = var.nodes[*]
}

output "kubernetes_version" {
  description = "Show K8S version"
  value       = rke_cluster.jd.kubernetes_version
}
