locals {
  name       = "jd_vpc"
  app        = "vpc"
  env        = "prod"
  department = "devops"
  region     = "us-west-2"

  cidr = "10.10.0.0/19"

  public_subnets  = ["10.10.20.0/24", "10.10.21.0/24", "10.10.22.0/24"]
  private_subnets = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]

  enable_vpn_gateway = false

  tags = {
    Name        = local.name
    App         = local.app
    Env         = local.env
    Dept        = local.department
    Terraformed = true
  }
}