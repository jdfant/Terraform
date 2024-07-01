resource "aws_cloudwatch_log_group" "kms_key_generator" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
  tags              = var.tags

  lifecycle {
    ignore_changes = [
      tags["Terraformed"]
    ]
  }
}