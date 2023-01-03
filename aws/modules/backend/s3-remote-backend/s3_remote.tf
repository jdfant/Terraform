data "aws_region" "current" {}
data "aws_partition" "current" {}

resource "aws_s3_bucket" "remote_backend" {
  bucket = "${var.app}-${var.env}-${var.bucket_remote_backend_suffix}"

  lifecycle {
    prevent_destroy = "true"
  }

  tags = {
    Name               = "${var.app}-${var.env}-${var.bucket_remote_backend_suffix}"
    App                = var.app
    Env                = var.env
    Department         = var.department
    Terraformed        = "true"
  }
}

resource "aws_s3_bucket_acl" "remote_backend" {
  bucket = aws_s3_bucket.remote_backend.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "remote_backend" {
  bucket = aws_s3_bucket.remote_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "remote_backend" {
  bucket = aws_s3_bucket.remote_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
