locals {
  region                       = "us-west-2"
  app                          = "terraform"
  env                          = "prod"
  department                   = "devops"
  bucket_remote_backend_suffix = "remote-backend"
  principals                   = ["arn:aws:iam::012345678910:root"]
}
