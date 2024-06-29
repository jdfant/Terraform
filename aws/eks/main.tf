terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # S3 remote backend w/Dynamodb locking:
  backend "s3" {
    encrypt        = "true"
    bucket         = "terraform-prod-remote-backend"
    key            = "prod-eks/terraform.tfstate"
    dynamodb_table = "prod-eks-state-lock"
    region         = "us-west-2"
  }
}