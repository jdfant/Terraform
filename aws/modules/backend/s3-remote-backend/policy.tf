resource "aws_iam_policy" "bucket_full_access" {
  count = var.enable_s3_bucket_policy ? 1 : 0

  name        = "s3-${var.app}-${var.env}-${var.bucket_remote_backend_suffix}-full-access"
  description = "Remote state S3 bucket access"
  path        = "/"
  policy      = data.aws_iam_policy_document.s3_full_access[0].json
}

resource "aws_iam_policy" "bucket_full_access_with_mfa" {
  count = var.enable_s3_bucket_policy_with_mfa ? 1 : 0

  name        = "${var.app}-${var.env}-${var.bucket_remote_backend_suffix}-s3-full-access-with-mfa"
  description = "Remote state S3 bucket access with mfa"
  path        = "/"
  policy      = data.aws_iam_policy_document.bucket_full_access_with_mfa[0].json
}

resource "aws_s3_bucket_policy" "s3_full_access" {
  bucket = aws_s3_bucket.remote_backend.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.remote_backend.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
