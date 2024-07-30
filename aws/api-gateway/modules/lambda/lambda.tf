resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.cwd}/files/${var.lambda_source_file}"
  output_path = "${path.cwd}/files/${var.lambda_function_output_path}"
}

resource "aws_lambda_function" "kms_key_generator" {
  filename      = var.lambda_function_output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.lambda_function_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout

  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_permission" "kms_key_generator_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.kms_key_generator.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.source_account}:${var.rest_api_id}/*"
}