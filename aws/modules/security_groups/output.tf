output "jd_aurora_security_group_id" {
  description = "The security group ID of the cluster"
  value       = aws_security_group.rds_sg.id
}
