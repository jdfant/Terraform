terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }

  # TF Cloud remote backend:
  #  cloud {
  #    organization = "jdfant"
  #    workspaces {
  #      name = "CLI"
  #    }
  #  }

  # S3 remote backend w/Dynamodb locking:
  backend "s3" {
    encrypt        = "true"
    bucket         = "terraform-prod-remote-backend"
    key            = "prod-vpc/terraform.tfstate"
    dynamodb_table = "prod-vpc-state-lock"
    region         = "us-west-2"
  }
}