data "aws_caller_identity" "current" {}

resource "aws_kms_key" "kms_key" {
  count  = var.create_key ? 1 : 0
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "${var.name}-${var.app}-${var.env}-key",
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
  name          = "alias/${var.name}-${var.app}-${var.env}"
  target_key_id = aws_kms_key.kms_key[0].id
}
