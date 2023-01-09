data "aws_iam_policy_document" "iam_user_policy" {
  version = "2012-10-17"

  statement {
    actions = [
      "rds-db:connect"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:rds-db:${var.region}:${var.account_id}:dbuser:*/*"
    ]
  }
}

data "aws_iam_policy_document" "db_access_policy" {
  version = "2012-10-17"

  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:DescribeParameters"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:ssm:${var.region}:${var.account_id}:parameter/${var.app}/${var.env}/db_access"
    ]
  }
}

data "aws_iam_policy_document" "monitoring_rds_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}
