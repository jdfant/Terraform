data "aws_partition" "current" {}

resource "aws_s3_bucket" "remote_backend" {
  bucket = "${var.name}-${var.bucket_remote_backend_suffix}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = "false"
  }

  tags = var.tags
}

resource "aws_s3_bucket_acl" "remote_backend" {
  bucket = aws_s3_bucket.remote_backend.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "remote_backend" {
  bucket = aws_s3_bucket.remote_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}