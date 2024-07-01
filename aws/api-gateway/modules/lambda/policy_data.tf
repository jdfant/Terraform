data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "apigateway.amazonaws.com",
        "lambda.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_service_role" {
  version = "2012-10-17"

  statement {
    actions = [
      "sts:AssumeRole"
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::${var.source_account}:root"
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_invoke" {
  version = "2012-10-17"

  statement {
    actions = [
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "lambda:InvokeFunction"
    ]

    resources = [
      "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:${var.lambda_function_name}"
    ]
  }
}

data "aws_iam_policy_document" "cloudwatch" {
  version = "2012-10-17"

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    effect = "Allow"

    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.lambda_function_name}:*"]
  }

  statement {
    actions = [
      "logs:CreateLogGroup"
    ]

    effect = "Allow"

    resources = ["*"]
  }
}