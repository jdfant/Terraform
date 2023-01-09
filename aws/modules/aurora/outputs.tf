output "jd_aurora_rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.jd_aurora.arn
}

output "jd_aurora_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.jd_aurora.id
}

output "jd_aurora_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = aws_rds_cluster.jd_aurora.cluster_resource_id
}

output "jd_aurora_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_rds_cluster.jd_aurora.endpoint
}

output "jd_aurora_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.jd_aurora.reader_endpoint
}

output "jd_aurora_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = aws_rds_cluster.jd_aurora.database_name
}

output "jd_aurora_rds_cluster_master_password" {
  description = "The master password"
  value       = random_password.master_password.result
  sensitive   = true
}

output "jd_aurora_rds_cluster_port" {
  description = "The port"
  value       = aws_rds_cluster.jd_aurora.port
}

output "jd_aurora_rds_cluster_master_username" {
  description = "The master username"
  value       = aws_rds_cluster.jd_aurora.master_username
}

output "jd_aurora_rds_cluster_aws_iam_user" {
  description = "Name for jd_aurora IAM User"
  value       = aws_iam_user.iam_user.name
}

output "jd_aurora_rds_cluster_hosted_zone_id" {
  description = "Route53 hosted zone id of the created cluster"
  value       = aws_rds_cluster.jd_aurora.hosted_zone_id
}

output "jd_aurora_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.jd_aurora.*.endpoint
}

output "jd_aurora_rds_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = aws_rds_cluster_instance.jd_aurora.*.id
}

output "jd_aurora_db_parameter_group_name" {
  description = "Instance Parameter Group Name"
  value       = aws_db_parameter_group.aurora_db_postgres13_parameter_group.id
}

output "jd_aurora_db_cluster_parameter_group_name" {
  description = "Cluster Parameter Group Name"
  value       = aws_rds_cluster_parameter_group.aurora_cluster_postgres13_parameter_group.id
}

output "aws_caller_identity_current_account_id" {
  description = "Account ID in which Terraform is working"
  value       = data.aws_caller_identity.current.account_id
}
