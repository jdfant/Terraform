data "aws_iam_policy_document" "sns_log_delivery_role" {

  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch_write_policy" {

  version = "2012-10-17"

  statement {
    actions = [
      "logs:Put*",
      "logs:Create*",
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.sns_current.name}:${var.sns_account}:log-group:sns/${data.aws_region.sns_current.name}/${data.aws_caller_identity.sns_current.account_id}/${var.sns_topic}*",
    ]
  }
}

data "aws_iam_policy_document" "sns_policy" {

  version = "2012-10-17"

  statement {
    actions = ["SNS:Publish"]
    effect  = "Allow"
    resources = [
      "arn:aws:sns:${data.aws_region.sns_current.name}:${var.sns_account}:${var.sns_topic}"
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"

      values = ["arn:aws:sns:${data.aws_region.sns_current.name}:${var.sns_account}:${var.sns_topic}"]
    }

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}
