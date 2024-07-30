locals {
  name                         = "kms-key-generator"
  region                       = "us-west-2"
  bucket_remote_backend_suffix = "remote-backend"

  tags = {
    Name        = "kms_key_generator"
    Terraformed = formatdate("MM-DD-YYYY", timestamp())
  }
}

