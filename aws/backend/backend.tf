module "s3_remote_backend_bucket" {
  source = "../modules/backend/s3-remote-backend"

  bucket_remote_backend_suffix = local.bucket_remote_backend_suffix
  app                          = local.app
  env                          = local.env
  department                   = local.department
  principals                   = local.principals
}

module "dynamo_locking_table" {
  source = "../modules/backend/dynamo-locking"

  app        = local.app
  env        = local.env
  department = local.department
}
