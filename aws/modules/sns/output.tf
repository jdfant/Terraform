output "arn" {
  description = "export sns topic ARN"
  value       = "arn:aws:sns:${data.aws_region.sns_current.name}:${var.sns_account}:${var.sns_topic}"
}
