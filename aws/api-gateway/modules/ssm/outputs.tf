output "kms_key_id" {
  description = "KMS Key ID."
  value       = aws_kms_key.ssm_kms_key[0].id
}

output "kms_key_arn" {
  description = "KMS Key ARN"
  value       = aws_kms_key.ssm_kms_key[0].id
}

output "ssm_iam_policy_document" {
  description = "SSM IAM Policy Document"
  value       = data.aws_iam_policy_document.ssm_kms_key
}