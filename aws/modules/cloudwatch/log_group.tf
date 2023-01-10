resource "aws_cloudwatch_log_group" "lambda_invoke_log_group" {
  name = "/aws/lambda/${var.results}-${var.app}"

  tags = {
    Name        = "${var.results}-${var.app}"
    Environment = var.env
    Terraformed = formatdate("MM-DD-YYYY", timestamp())
    Department  = var.department
  }

  lifecycle {
    ignore_changes = [
      tags["Terraformed"]
    ]
  }
}

resource "aws_cloudwatch_log_group" "error_log_group" {
  name = "${var.app}-${var.env}-error-log-group"

  tags = {
    Name        = "${var.app}-${var.env}-error-log-group"
    Environment = var.env
    Terraformed = formatdate("MM-DD-YYYY", timestamp())
    Department  = var.department
  }

  lifecycle {
    ignore_changes = [
      tags["Terraformed"]
    ]
  }
}