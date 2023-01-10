resource "aws_sns_topic" "lambda_topic" {
  name = var.sns_topic

  delivery_policy = file("${path.module}/delivery_policies/sns_delivery_policy.json")

  http_success_feedback_role_arn    = aws_iam_role.http_delivery_role[0].arn
  http_success_feedback_sample_rate = var.http_success_feedback_sample_rate
  http_failure_feedback_role_arn    = aws_iam_role.http_delivery_role[0].arn

  policy = data.aws_iam_policy_document.sns_policy[0].json

  tags = {
    Name        = var.sns_topic
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

resource "aws_lambda_permission" "allow_invocation_from_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = "arn:aws:sns:${var.region}:${var.sns_account}:${var.sns_topic}"
}

resource "aws_sns_topic_subscription" "topic_subscription" {
  topic_arn = "arn:aws:sns:${var.region}:${var.sns_account}:${var.sns_topic}"
  protocol  = "lambda"
  endpoint  = var.sns_endpoint
}
