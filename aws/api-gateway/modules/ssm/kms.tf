data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ssm_kms_key" {
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

resource "aws_iam_policy" "lambda_invoke" {
  name   = "${var.lambda_function_name}-invoke-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.ssm_kms_key.json
}

resource "aws_kms_key" "ssm_kms_key" {
  count  = var.create_key ? 1 : 0
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "${var.ssm_kms_key_alias}-key",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_kms_alias" "kms_key_alias" {
  count         = var.create_key ? 1 : 0
  name          = "alias/${var.ssm_kms_key_alias}"
  target_key_id = aws_kms_key.ssm_kms_key[0].id
}