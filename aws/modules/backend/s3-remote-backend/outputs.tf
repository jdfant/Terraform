output "region" {
  description = "Region remote backend bucket created in."
  value       = aws_s3_bucket.remote_backend.region
}

output "url" {
  description = "URL to the remote backend S3 bucket."
  value       = "https://s3-${aws_s3_bucket.remote_backend.region}.amazonaws.com/${aws_s3_bucket.remote_backend.id}"
}

output "principals" {
  description = "List of IAM user/role ARNs with access to the bucket."
  value       = var.principals
}

output "bucket_full_access_policy_arn" {
  description = "ARN of IAM policy that grants access to the bucket (without requiring MFA)."
  value       = aws_iam_policy.bucket_full_access.*.arn
}

output "bucket_full_access_with_mfa_policy_arn" {
  description = "ARN of IAM policy that grants access to the bucket (with MFA required)."
  value       = aws_iam_policy.bucket_full_access_with_mfa.*.arn
}

output "bucket_arn" {
  description = "ARN of remote backend bucket."
  value       = aws_s3_bucket.remote_backend.arn
}

output "bucket_id" {
  description = "Id of remote backend bucket."
  value       = aws_s3_bucket.remote_backend.id
}
