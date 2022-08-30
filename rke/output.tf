output "all_nodes" {
  description = "Show details for all nodes"
  value       = var.nodes[*]
}
