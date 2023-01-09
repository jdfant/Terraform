provider "aws" {
  region = local.region
}

module "security_groups" {
  source = "../modules/security_groups"

  app                          = local.app
  env                          = local.env
  department                   = local.department
  vpc_id                       = local.vpc_id
  vpc_cidr                     = local.vpc_cidr
  office_cidr                  = local.office_cidr
  public_subnets               = local.public_subnets
  private_subnets              = local.private_subnets
  security_group_description   = local.security_group_description
  security_group_allowed_cidrs = local.security_group_allowed_cidrs
}

module "ssm" {
  source = "../modules/ssm"

  name          = local.name
  app           = local.app
  env           = local.env
  department    = local.department
  database_name = local.database_name
  aws_iam_user  = local.aws_iam_user
  db_host       = module.aurora.jd_aurora_rds_cluster_endpoint
  password      = module.aurora.jd_aurora_rds_cluster_master_password
}

module "aurora" {
  source = "../modules/aurora"

  app        = local.app
  env        = local.env
  identifier = local.identifier
  account_id = local.account_id

  name                            = local.name
  aws_iam_user                    = local.aws_iam_user
  database_name                   = local.database_name
  engine_mode                     = local.engine_mode
  engine                          = local.engine
  engine_version                  = local.engine_version
  storage_encrypted               = local.storage_encrypted
  subnets                         = local.public_subnets
  vpc_cidr                        = local.vpc_cidr
  replica_scale_enabled           = false
  replica_count                   = local.replica_count
  monitoring_interval             = 0
  backup_retention_period         = local.backup_retention_period
  instance_type                   = local.instance_type
  apply_immediately               = true
  skip_final_snapshot             = true
  db_parameter_group              = local.db_parameter_group
  db_parameter_group_name         = module.aurora.jd_aurora_db_parameter_group_name
  db_cluster_parameter_group_name = module.aurora.jd_aurora_db_cluster_parameter_group_name
  rds_cluster_parameter_group     = local.rds_cluster_parameter_group
  vpc_security_group_ids          = [module.security_groups.jd_aurora_security_group_id]
  enabled_cloudwatch_logs_exports = ["postgresql"]

  instances_parameters = [
    {
      instance_type       = local.instance_type
      publicly_accessible = local.publicly_accessible
    }
  ]
}
