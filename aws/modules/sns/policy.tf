data "aws_caller_identity" "sns_current" {}
data "aws_region" "sns_current" {}

resource "aws_iam_role" "http_delivery_role" {
  name               = "${var.sns_topic}-log-role"
  description        = "Role for ${var.sns_topic} SNS topic."
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sns_log_delivery_role.json

  tags = {
    Name        = "${var.sns_topic}-sns-log-delivery-role"
    Environment = var.env
    Terraformed = formatdate("MM-DD-YYYY", timestamp())
    Family      = var.family
    Department  = var.dept
  }

  lifecycle {
    ignore_changes = [
      tags["Terraformed"]
    ]
  }
}

resource "aws_iam_policy" "cloudwatch_write_policy" {
  name        = "${var.sns_topic}-cloudwatch-policy"
  description = "Allows ${var.sns_topic} SNS topic to write to Cloudwatch logs."
  path        = "/"
  policy      = data.aws_iam_policy_document.cloudwatch_write_policy.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_write_attach" {
  role       = aws_iam_role.http_delivery_role.name
  policy_arn = aws_iam_policy.cloudwatch_write_policy.arn
}
