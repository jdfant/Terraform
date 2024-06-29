# Values below inherited from:
# https://github.com/jdfant/Terraform/blob/08f0c832c4bf32bc95c6c08076a0dc935db50377/aws/vpc/main.tf#L19

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "terraform-prod-remote-backend"
    key            = "prod-vpc/terraform.tfstate"
    dynamodb_table = "prod-vpc-state-lock"
    region         = "us-west-2"
  }
}