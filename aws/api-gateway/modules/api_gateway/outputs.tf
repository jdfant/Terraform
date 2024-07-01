output "rest_api_id" {
  value = aws_api_gateway_rest_api.kms_key_generator.id
}

output "aws_caller_identity_current_account_id" {
  description = "Account ID in which Terraform is working"
  value       = data.aws_caller_identity.current.account_id
}