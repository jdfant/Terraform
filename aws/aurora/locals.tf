locals {
  app                         = "jd_aurora"
  env                         = "prod"
  account_id                  = "1234567890"
  vpc_id                      = "vpc-xxxxxxxxxxxxxxxxx"
  vpc_cidr                    = ["10.10.16.0/21"]
  region                      = "us-west-2"
  name                        = "jd-aurora-prod"
  database_name               = "jd_aurora"
  identifier                  = ""
  instance_type               = "db.serverless"
  replica_count               = "2"
  engine_mode                 = "serverless"
  engine                      = "aurora-postgresql"
  engine_version              = "13.6"
  publicly_accessible         = "true"
  storage_encrypted           = "true"
  department                  = "devops"
  backup_retention_period     = "7"
  rds_cluster_parameter_group = "aurora-postgres13-cluster-parameter-group"
  db_parameter_group          = "aurora-db-postgres13-parameter-group"
  aws_iam_user                = "jd_aurora_db"
  security_group_description  = "Managed by Terraform"

  security_group_allowed_cidrs = ["12.34.56.78/32", "10.11.12.13/32"]
  office_cidr                  = ["20.30.40.0/30"]
  public_subnets               = ["subnet-00000000000000001", "subnet-00000000000000002", "subnet-00000000000000003"]
  private_subnets              = ["subnet-11111111111111111", "subnet-11111111111111112", "subnet-11111111111111113"]
}
