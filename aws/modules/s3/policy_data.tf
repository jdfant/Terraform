data "aws_iam_policy_document" "read_s3_policy" {
  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = [
      "arn:${var.aws_partition_arn}:s3:::${aws_s3_bucket.lambda_bucket.id}",
      "arn:${var.aws_partition_arn}:s3:::${aws_s3_bucket.lambda_bucket.id}/*",
    ]
  }
}

data "aws_iam_policy_document" "write_s3_policy" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:AbortMultipartUpload",
    ]

    resources = [
      "arn:${var.aws_partition_arn}:s3:::${aws_s3_bucket.lambda_bucket.id}",
      "arn:${var.aws_partition_arn}:s3:::${aws_s3_bucket.lambda_bucket.id}/*",
    ]
  }
}

data "aws_iam_policy_document" "s3_bucket_visibility_policy" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }
}
