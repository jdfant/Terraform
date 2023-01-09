terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source                = "hashicorp/aws",
      version               = "~> 4.0"
      configuration_aliases = [aws.db]
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
    key            = "prod-aurora/terraform.tfstate"
    dynamodb_table = "prod-aurora-state-lock"
    region         = "us-west-2"
  }
}
