data "archive_file" "lambda_function_zip" {
  type        = "zip"
  output_path = var.lambda_function_output_path
  source_dir  = var.lambda_function_source_dir
  excludes    = fileset(var.lambda_function_source_dir, "*.zip")
}

data "archive_file" "lambda_layer_zip" {
  type        = "zip"
  output_path = var.lambda_layer_output_path
  source_dir  = var.lambda_layer_source_dir
  excludes    = fileset(var.lambda_layer_source_dir, "*.zip")
}

resource "aws_s3_object" "lambda_function_upload" {
  bucket = var.s3_bucket
  key    = basename(data.archive_file.lambda_function_zip.output_path)
  source = data.archive_file.lambda_function_zip.output_path
  etag   = filemd5(data.archive_file.lambda_function_zip.output_path)
}

resource "aws_s3_object" "lambda_layer_upload" {
  bucket = var.s3_bucket
  key    = basename(data.archive_file.lambda_layer_zip.output_path)
  source = data.archive_file.lambda_layer_zip.output_path
  etag   = filemd5(data.archive_file.lambda_layer_zip.output_path)
}

resource "aws_lambda_function" "main" {
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key_function
  s3_object_version              = aws_s3_object.lambda_function_upload.version_id
  function_name                  = "${var.results}-${var.app}"
  role                           = aws_iam_role.lambda_service_role.arn
  handler                        = var.handler
  source_code_hash               = data.archive_file.lambda_function_zip.output_base64sha256
  runtime                        = var.runtime
  layers                         = var.layers
  memory_size                    = var.memory_size
  description                    = var.description
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions
  publish                        = var.publish

  dynamic "environment" {
    for_each = var.env_vars == null ? [] : [1]
    content {
      variables = var.env_vars
    }
  }

  dynamic "vpc_config" {
    for_each = var.subnet_ids == null || var.security_group_ids == null ? [] : [1]
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }

  //depends_on = [aws_iam_role_policy_attachment.cloudwatch_write_attach]

  tags = {
    Name        = "${var.results}-${var.app}"
    Environment = var.env
    Terraformed = formatdate("MM-DD-YYYY", timestamp())
    Department  = var.department
  }
}

resource "aws_lambda_layer_version" "lambda_layer" {
  s3_key              = var.s3_key_layer
  s3_bucket           = var.s3_bucket
  s3_object_version   = aws_s3_object.lambda_layer_upload.version_id
  layer_name          = var.layer_name
  compatible_runtimes = [var.layer_runtime]
}

resource "aws_lambda_alias" "lambda_alias_stage" {
  name             = "STAGE"
  description      = "STAGE alias"
  function_name    = aws_lambda_function.main.arn
  function_version = var.stage_alias
}

data "template_file" "lambda_payload" {
  template = file(var.lambda_payload,)
}

data "aws_lambda_invocation" "invocation_test" {
  depends_on    = [aws_s3_object.lambda_function_upload]
  function_name = aws_lambda_function.main.function_name
  input         = data.template_file.lambda_payload.rendered
}

resource "aws_lambda_function_event_invoke_config" "stage" {
  function_name                = aws_lambda_alias.lambda_alias_stage.function_name
  qualifier                    = aws_lambda_alias.lambda_alias_stage.name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 2
}

resource "aws_lambda_permission" "bucket_notification" {
  for_each       = toset(var.source_arn)
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.main.function_name
  principal      = "s3.amazonaws.com"
  source_arn     = each.key
  source_account = var.source_account
}

#
# !! This will REMOVE all existing event notifications if Terraform did not create them !!
#
resource "aws_s3_bucket_notification" "bucket_notification" {
  for_each = var.s3_lambda_notifications
  bucket   = each.key

  dynamic "lambda_function" {
    for_each = var.s3_lambda_notifications[each.key]
    content {
      events              = lambda_function.value.events
      lambda_function_arn = lambda_function.value.lambda_function_arn
      id                  = lambda_function.value.id
      filter_prefix       = lambda_function.value.filter_prefix
      filter_suffix       = lambda_function.value.filter_suffix
    }
  }
}
