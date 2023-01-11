data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_lambda_function.main.function_name}",
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${var.db_access}"
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

    effect    = "Allow"

    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.results}-${var.app}:*"]
  }

  statement {
    actions = [
      "logs:CreateLogGroup"
    ]

    effect    = "Allow"

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "service_user_access" {
  version = "2012-10-17"

  statement {
    actions = [
      "rds-db:connect"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:rds-db:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:*/*"
    ]
  }
}

data "aws_iam_policy_document" "s3_triggers_xacct" {
  version = "2012-10-17"

  statement {
    actions = [
      "lambda:InvokeFunction"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${aws_lambda_function.main.function_name}:${var.lambda_alias}"
    ]
  }
}
