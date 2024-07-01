locals {
  name                         = "kms-key-generator"
  region                       = "us-west-2"
  source_account               = "012345678910"
  rest_api_name                = "kms_key_generator"
  rest_api_id                  = module.api_gateway.rest_api_id
  api_gateway_stage_name       = "kms_key_generator"
  api_gateway_authorization    = "NONE"
  integration_http_method      = "POST"
  endpoint_path                = "/kms_key_generator"
  endpoint_configuration_type  = ["REGIONAL"]
  api_gateway_integration_type = "AWS"
  api_key                      = "xxxxxxxxxxxxxxxxxxxxxxxxx"
  api_key_required             = true
  api_execution_source_ip      = ["192.168.1.2/32"]
  path_part                    = "kms_key_generator"
  ssm_kms_key_alias            = "KMSKeyGeneratorSSMParameterStore"
  ssm_parameter_store_name     = "/APIGateway/APIKeys/kms_key_generator"
  ssm_parameter_store_type     = "SecureString"
  create_key                   = true
  lambda_function_name         = "kms_key_generator"
  lambda_runtime               = "python3.11"
  lambda_timeout               = 60
  lambda_function_handler      = "lambda_function.lambda_handler"
  lambda_source_file           = "lambda_function.py"
  lambda_function_output_path  = "lambda_function.zip"
  lambda_invoke_arn            = module.lambda.lambda_invoke_arn
  lambda_invoke_policy_arn = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::xxxxxxxxxxx:policy/lambda-results-cloudwatch-policy",
    "arn:aws:iam::xxxxxxxxxxx:policy/lambda-results-invoke-policy",
    "arn:aws:iam::xxxxxxxxxxx:policy/lambda-results-service-user-access-policy",
    "arn:aws:iam::xxxxxxxxxxx:policy/lambda-results-s3-triggers-xacct-policy",
    "arn:aws:iam::xxxxxxxxxxx:policy/CrossAccountConfig"
  ]

  tags = merge(
    { "Name"        = local.name,
      "Terraformed" = formatdate("MM-DD-YYYY", timestamp())
    },
  )
}