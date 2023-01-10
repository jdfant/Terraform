output "lambda_bucket_arn" {
  description = "bucket arn to be exported"
  value       = module.s3.lambda_bucket_arn
}

output "lambda_bucket_name" {
  description = "name of s3 bucket to be exported"
  value       = module.s3.lambda_bucket_name
}
