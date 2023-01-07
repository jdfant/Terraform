provider "aws" {
  region = local.region
}

module "vpc" {
  source = "../modules/vpc"

  name = local.name
  cidr = local.cidr

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  private_subnet_names = ["Private Subnet One", "Private Subnet Two", "Private Subnet Three"]

  enable_vpn_gateway = local.enable_vpn_gateway

  tags = local.tags
}

/*
# For VPN creation, uncomment this block and 'cgw/customer_gateway references in output.tf
  customer_gateways = {
    IP1 = {
      bgp_asn     = 65112
      ip_address  = "1.2.3.4"
      device_name = "some_name"
    },
    IP2 = {
      bgp_asn    = 65112
      ip_address = "5.6.7.8"
    }
  }

  tags = {
    Name        = local.name
    App         = local.app
    Env         = local.env
    Dept        = local.department
    Terraformed = true
  }
}
*/