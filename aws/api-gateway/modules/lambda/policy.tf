resource "aws_iam_role" "lambda_service_role" {
  name               = "${var.lambda_function_name}-service-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_service_role.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "service_role_policies" {
  role       = aws_iam_role.lambda_service_role.name
  count      = length(var.lambda_invoke_policy_arn)
  policy_arn = var.lambda_invoke_policy_arn[count.index]
}

resource "aws_iam_policy" "cloudwatch" {
  name        = "${var.lambda_function_name}-cloudwatch-policy"
  path        = "/"
  description = "Cloudwatch logging policy for ${var.lambda_function_name}"
  policy      = data.aws_iam_policy_document.cloudwatch.json
}

resource "aws_iam_policy" "lambda_invoke" {
  name   = "${var.lambda_function_name}-invoke-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_invoke.json
}

