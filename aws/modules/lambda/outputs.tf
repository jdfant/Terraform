output "invoke_arn" {
  value       = aws_lambda_function.main.invoke_arn
  description = "Invocation ARN for lambda function."
}

output "function_name" {
  value       = aws_lambda_function.main.function_name
  description = "Function name of lambda function"
}

output "function_arn" {
  value       = aws_lambda_function.main.arn
  description = "Function arn of lambda function"
}

output "execution_role_arn" {
  value       = aws_iam_role.lambda_service_role.arn
  description = "ARN of execution role for lambda function."
}

output "execution_role_name" {
  value       = aws_iam_role.lambda_service_role.name
  description = "Name of execution role for lambda function."
}

output "s3_bucket_upload_name" {
  value       = aws_s3_object.lambda_function_upload.bucket
  description = "Name of S3 upload bucket."
}

output "s3_bucket_object_key" {
  value       = aws_s3_object.lambda_function_upload.key
  description = "The key of the S3 bucket upload bject."
}

output "s3_bucket_upload_source" {
  value       = data.archive_file.lambda_function_zip.output_path
  description = "Source for the S3 upload."
}

output "s3_bucket_object_version" {
  value       = aws_lambda_function.main.s3_object_version
  description = "The version of the S3 bucket upload oject."
}

output "lambda_function_source_dir" {
  value       = data.archive_file.lambda_function_zip.source_dir
  description = "Directory containing files to be added to the Lambda function zip file"
}

output "lambda_layer_source_dir" {
  value       = data.archive_file.lambda_layer_zip.source_dir
  description = "Directory containing files to be added to the Lambda layer zip file"
}

output "lambda_layers" {
  value       = aws_lambda_layer_version.lambda_layer.arn
  description = "Name of the lambda layer(s)."
}

output "lambda_alias" {
  value       = aws_lambda_alias.lambda_alias_stage.name
  description = "Name of the lambda layer(s)."
}

output "lambda_latest_version" {
  value       = aws_lambda_function.main.version
  description = "Latest version of the lambda"
}
