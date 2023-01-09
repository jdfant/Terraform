output "jd_aurora_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = module.aurora.jd_aurora_rds_cluster_id
}

output "jd_aurora_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.aurora.jd_aurora_rds_cluster_resource_id
}

output "jd_aurora_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.aurora.jd_aurora_rds_cluster_endpoint
}

output "jd_aurora_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.aurora.jd_aurora_rds_cluster_reader_endpoint
}

output "jd_aurora_rds_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora.jd_aurora_rds_cluster_database_name
}

output "jd_aurora_rds_cluster_master_username" {
  description = "The master username"
  value       = module.aurora.jd_aurora_rds_cluster_master_username
}

output "jd_aurora_rds_cluster_master_password" {
  description = "The master password"
  value       = module.aurora.jd_aurora_rds_cluster_master_password
  sensitive   = true
}

output "jd_aurora_rds_cluster_aws_iam_user" {
  description = "Name for jd_aurora IAM User"
  value       = module.aurora.jd_aurora_rds_cluster_aws_iam_user
}

output "jd_aurora_rds_cluster_port" {
  description = "The port"
  value       = module.aurora.jd_aurora_rds_cluster_port
}

output "jd_aurora_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.aurora.jd_aurora_rds_cluster_instance_endpoints
}

output "jd_aurora_rds_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = module.aurora.jd_aurora_rds_cluster_instance_ids
}

output "jd_aurora_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.security_groups.jd_aurora_security_group_id
}

output "kms_key_arn" {
  description = "KMS Key ARN"
  value       = module.ssm.kms_key_arn
}

output "aws_caller_identity_current_account_id" {
  description = "Account ID in which Terraform is working"
  value       = module.aurora.aws_caller_identity_current_account_id
}
