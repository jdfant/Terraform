output "lambda_invoke_log_group_arn" {
  description = "Lambda invoke cloudwatch group ARN."
  value       = aws_cloudwatch_log_group.lambda_invoke_log_group.arn
}

output "log_group_arns" {
  description = "List of cloudwatch group ARNs."
  value = [
    aws_cloudwatch_log_group.lambda_invoke_log_group.arn
  ]
}

output "lambda_invoke_log_group_name" {
  description = "Lambda invoke cloudwatch group name."
  value       = aws_cloudwatch_log_group.lambda_invoke_log_group.name
}
