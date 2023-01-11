terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source                = "hashicorp/aws",
      version               = "~> 4.0"
      configuration_aliases = [aws.lambda]
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
    key            = "prod-lambda/terraform.tfstate"
    dynamodb_table = "prod-lambda-state-lock"
    region         = "us-west-2"
  }
}
