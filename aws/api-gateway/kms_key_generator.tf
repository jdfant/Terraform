module "api_gateway" {
  source = "./modules/api_gateway"

  rest_api_name                = local.rest_api_name
  endpoint_path                = local.endpoint_path
  path_part                    = local.path_part
  api_gateway_stage_name       = local.api_gateway_stage_name
  lambda_invoke_arn            = local.lambda_invoke_arn
  integration_http_method      = local.integration_http_method
  endpoint_configuration_type  = local.endpoint_configuration_type
  api_gateway_authorization    = local.api_gateway_authorization
  api_gateway_integration_type = local.api_gateway_integration_type
  api_key_required             = local.api_key_required
  api_execution_source_ip      = local.api_execution_source_ip
  tags                         = local.tags
}

module "lambda" {
  source = "./modules/lambda"

  region                      = local.region
  lambda_function_handler     = local.lambda_function_handler
  lambda_invoke_policy_arn    = local.lambda_invoke_policy_arn
  lambda_runtime              = local.lambda_runtime
  lambda_timeout              = local.lambda_timeout
  source_account              = local.source_account
  lambda_function_name        = local.lambda_function_name
  lambda_source_file          = local.lambda_source_file
  lambda_function_output_path = local.lambda_function_output_path
  rest_api_id                 = local.rest_api_id
  tags                        = local.tags
}

module "ssm" {
  source = "./modules/ssm"

  name                     = local.name
  create_key               = local.create_key
  api_key                  = local.api_key
  ssm_kms_key_alias        = local.ssm_kms_key_alias
  ssm_parameter_store_name = local.ssm_parameter_store_name
  ssm_parameter_store_type = local.ssm_parameter_store_type
  tags                     = local.tags
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  tags = local.tags
}