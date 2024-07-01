/*
data "aws_api_gateway_rest_api" "my_rest_api" {
  name = var.rest_api_name
}

data "aws_api_gateway_resource" "my_resource" {
  rest_api_id = data.aws_api_gateway_rest_api.my_rest_api.id
  path        = var.endpoint_path
}
*/

data "aws_caller_identity" "current" {
}

data "aws_iam_policy_document" "kms_key_generator" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = [aws_api_gateway_rest_api.kms_key_generator.execution_arn]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.api_execution_source_ip
    }
  }
}

resource "aws_api_gateway_rest_api_policy" "kms_key_generator_api" {
  rest_api_id = aws_api_gateway_rest_api.kms_key_generator.id
  policy      = data.aws_iam_policy_document.kms_key_generator.json
}

resource "aws_api_gateway_rest_api" "kms_key_generator" {
  name        = var.rest_api_name
  description = "REST API for KMS Key Generator"

  endpoint_configuration {
    types = var.endpoint_configuration_type
  }
}

resource "aws_api_gateway_resource" "kms_key_generator" {
  rest_api_id = aws_api_gateway_rest_api.kms_key_generator.id
  parent_id   = aws_api_gateway_rest_api.kms_key_generator.root_resource_id
  path_part   = var.path_part
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id      = aws_api_gateway_rest_api.kms_key_generator.id
  resource_id      = aws_api_gateway_resource.kms_key_generator.id
  http_method      = var.integration_http_method
  authorization    = var.api_gateway_authorization
  api_key_required = var.api_key_required
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.kms_key_generator.id
  resource_id             = aws_api_gateway_resource.kms_key_generator.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = var.integration_http_method
  type                    = var.api_gateway_integration_type
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "default" {
  rest_api_id = aws_api_gateway_rest_api.kms_key_generator.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.kms_key_generator.body))
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_api_gateway_method.post_method, aws_api_gateway_integration.lambda_integration]
}

resource "aws_api_gateway_stage" "kms_key_generator" {
  deployment_id = aws_api_gateway_deployment.default.id
  rest_api_id   = aws_api_gateway_rest_api.kms_key_generator.id
  stage_name    = var.api_gateway_stage_name
}