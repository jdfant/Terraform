module "s3_remote_backend_bucket" {
  source = "../modules/remote_backend/s3-remote-backend"

  bucket_remote_backend_suffix = local.bucket_remote_backend_suffix
  name                         = local.name
  tags                         = local.tags
}

module "dynamo_locking_table" {
  source = "../modules/remote_backend/dynamo-locking"

  name = local.name
  tags = local.tags
}
