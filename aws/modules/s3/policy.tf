resource "aws_iam_policy" "write_s3_policy" {
  description = "${var.app}-${var.env}-write_s3_policy"
  path        = "/"
  policy      = data.aws_iam_policy_document.write_s3_policy.json
}

resource "aws_iam_policy" "read_s3_policy" {
  description = "${var.app}-${var.env}-read_s3_policy"
  path        = "/"
  policy      = data.aws_iam_policy_document.read_s3_policy.json
}

resource "aws_iam_policy" "bucket_visibility_policy" {
  description = "${var.app}-${var.env}-bucket-visibility-policy"
  path        = "/"
  policy      = data.aws_iam_policy_document.s3_bucket_visibility_policy.json
}
