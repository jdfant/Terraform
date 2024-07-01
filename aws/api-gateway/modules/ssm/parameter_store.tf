resource "aws_ssm_parameter" "api_key" {
  name   = var.ssm_parameter_store_name
  type   = var.ssm_parameter_store_type
  value  = var.api_key
  key_id = aws_kms_key.ssm_kms_key[0].id
  tags   = var.tags

  lifecycle {
    ignore_changes = [value]
  }
}