output "lambda_bucket_arn" {
  description = "bucket arn to be exported"
  value       = aws_s3_bucket.lambda_bucket.arn
}

output "lambda_bucket_name" {
  description = "name of s3 bucket to be exported"
  value       = aws_s3_bucket.lambda_bucket.id
}
