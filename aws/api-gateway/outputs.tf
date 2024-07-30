/*
output "lambda_invoke_arn" {
  value       = module.lambda.invoke_arn
  description = "Invocation ARN for lambda function."
}
*/

output "aws_caller_identity_current_account_id" {
  description = "Account ID in which Terraform is working"
  value       = module.api_gateway.aws_caller_identity_current_account_id
}

output "lambda_arn" {
  value       = module.lambda.lambda_invoke_arn
  description = "ARN for lambda function."
}
output "function_name" {
  value       = module.lambda.function_name
  description = "Function name of lambda function"
}

output "execution_role_arn" {
  value       = module.lambda.execution_role_arn
  description = "ARN of execution role for lambda function."
}

output "execution_role_name" {
  value       = module.lambda.execution_role_name
  description = "Name of execution role for lambda function."
}

output "cloudwatch_log_group_arns" {
  value       = module.cloudwatch.log_group_arns
  description = "List of cloudwatch log groups."
}

output "ssm_kms_key_arn" {
  description = "SSM KMS Key ARN"
  value       = module.ssm.kms_key_arn
}

