output "invoke_arn" {
  value       = module.lambda.invoke_arn
  description = "Invocation ARN for lambda function."
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

output "lambda_layers" {
  value       = module.lambda.lambda_layers
  description = "Name of the lambda layer(s)."
}

output "lambda_alias" {
  value       = module.lambda.lambda_alias
  description = "Lambda Alias"
}

output "lambda_latest_version" {
  value       = module.lambda.lambda_latest_version
  description = "Lambda 'latest'version number"
}

output "s3_bucket_upload_name" {
  value       = module.lambda.s3_bucket_upload_name
  description = "Name of S3 upload bucket."
}

output "s3_bucket_object_key" {
  value       = module.lambda.s3_bucket_object_key
  description = "The key of the S3 bucket upload object."
}

output "cloudwatch_log_group_arns" {
  value       = module.cloudwatch.log_group_arns
  description = "List of cloudwatch log groups."
}
