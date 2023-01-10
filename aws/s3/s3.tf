provider "aws" {
  region  = local.region
}

module "s3" {
  source = "../modules/s3"

  app           = local.app
  env           = local.env
  department    = local.department
  create_bucket = local.create_bucket

  versioning = {
    status     = true
    mfa_delete = false
  }
}
