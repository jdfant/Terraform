provider "aws" {
  alias  = "lambda"
  region = "us-west-2"
}

module "lambda" {
  source = "../modules/lambda"

  app                         = local.app
  env                         = local.env
  department                  = local.department
  handler                     = local.handler
  runtime                     = local.runtime
  timeout                     = local.timeout
  results                     = local.results
  s3_bucket                   = local.s3_bucket
  s3_lambda_notifications     = local.s3_lambda_notifications
  s3_key_function             = local.s3_key_function
  s3_key_layer                = local.s3_key_layer
  source_arn                  = local.source_arn
  source_account              = local.source_account
  layers                      = [module.lambda.lambda_layers]
  layer_name                  = local.layer_name
  layer_runtime               = local.layer_runtime
  lambda_payload              = local.lambda_payload
  env_vars                    = local.env_vars
  db_access                   = local.db_access
  publish                     = local.publish
  stage_alias                 = local.stage_alias
  lambda_alias                = local.lambda_alias
  invoke_policy_arn           = local.invoke_policy_arn
  security_group_ids          = local.security_group_ids
  subnet_ids                  = local.subnet_ids
  lambda_function_source_dir  = local.lambda_function_source_dir
  lambda_function_output_path = local.lambda_function_output_path
  lambda_layer_source_dir     = local.lambda_layer_source_dir
  lambda_layer_output_path    = local.lambda_layer_output_path
}

module "cloudwatch" {
  source = "../modules/cloudwatch"

  app        = local.app
  env        = local.env
  department = local.department
  results    = local.results
}
