locals {
  app        = "lambda"
  env        = "prod"
  department = "devops"
  handler    = "lambda_function.lambda_handler"
  publish    = true

  security_group_ids = [
    "xxxxxxxxxxxxxxx"
  ]

  subnet_ids = [
    "subnet-xxxxxxxxxxxxxxxxx",
    "subnet-xxxxxxxxxxxxxxxxx",
    "subnet-xxxxxxxxxxxxxxxxx"
  ]

  invoke_policy_arn = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::xxxxxxxxxxx:policy/lambda-results-cloudwatch-policy",
    "arn:aws:iam::xxxxxxxxxxx:policy/lambda-results-invoke-policy",
    "arn:aws:iam::xxxxxxxxxxx:policy/lambda-results-service-user-access-policy",
    "arn:aws:iam::xxxxxxxxxxx:policy/lambda-results-s3-triggers-xacct-policy",
    "arn:aws:iam::xxxxxxxxxxx:policy/CrossAccountConfig"
  ]

  s3_bucket       = "lambda_bucket"
  s3_key_function = "lambda_results.zip"
  s3_key_layer    = "lambda_results_layer.zip"

  source_account = "111111111111"
  db_access      = "/jd_aurora_db/prod/db_access"
  timeout        = 60
  runtime        = "python3.9"
  layer_runtime  = "python3.9"
  results        = "results"
  lambda_alias   = "PROD"
  stage_alias    = "$LATEST"

  layer_name                  = "./files/lambda_results_layer"
  lambda_payload              = "./files/payload_files/lambda_results_payload"
  lambda_function_source_dir  = "./files/lambda_result_function"
  lambda_layer_source_dir     = "./files/layers/lambda_layer"
  lambda_function_output_path = "./files/lambda_zip_archives/lambda_results.zip"
  lambda_layer_output_path    = "./files/lambda_zip_archives/lambda_results_layer.zip"

  source_arn = [
    "arn:aws:s3:::lambda-results-prod",
    "arn:aws:s3:::lambda-results-stage"
  ]

  env_vars = {
    DB_ENV = "prod"
  }

  s3_lambda_notifications = {

    "s3-results-stage" = [
      {
        events              = ["s3:ObjectCreated:*"],
        lambda_function_arn = "arn:aws:lambda:us-west-2:111111111111:function:lambda_results:STAGE"
        id                  = "lambda_trigger",
        filter_prefix       = "",
        filter_suffix       = "lambda_results.zip",
      }
    ]

    "s3-results-prod" = [
      {
        events              = ["s3:ObjectCreated:*"],
        lambda_function_arn = "arn:aws:lambda:us-west-2:111111111111:function:lambda_results:PROD"
        id                  = "sendDataToS2",
        filter_prefix       = "",
        filter_suffix       = "results.json",
      },
      {
        events              = ["s3:ObjectCreated:*"],
        lambda_function_arn = "arn:aws:lambda:us-west-2:111111111111:function:lambda_files_upload:PROD"
        id                  = "sendDataToRT",
        filter_prefix       = "",
        filter_suffix       = ".IDT.xlsx",
      },
      {
        events              = ["s3:ObjectCreated:*"],
        lambda_function_arn = "arn:aws:lambda:us-west-2:111111111111:function:lambda_files_upload:PROD"
        id                  = "sendDataToSD",
        filter_prefix       = "",
        filter_suffix       = ".gtf",
      }
    ]
  }
}
