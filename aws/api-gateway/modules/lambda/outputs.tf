output "lambda_invoke_arn" {
  value       = aws_lambda_function.kms_key_generator.invoke_arn
  description = "Invocation ARN for lambda function"
}

output "function_name" {
  value       = aws_lambda_function.kms_key_generator.function_name
  description = "Name of lambda function"
}

output "execution_role_arn" {
  value       = aws_iam_role.iam_for_lambda.arn
  description = "Execution Role ARN"
}

output "execution_role_name" {
  value       = aws_iam_role.iam_for_lambda.name
  description = "Execution Role Name"
}