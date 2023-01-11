resource "aws_iam_role" "lambda_service_role" {
  name               = "${var.results}-${var.app}-service-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_service_role.json
  tags = {
    Name        = "${var.results}-${var.app}-service-role"
    Environment = var.env
    Terraformed = formatdate("MM-DD-YYYY", timestamp())
    Department  = var.department
  }
}

resource "aws_iam_policy" "cloudwatch" {
  name        = "${var.results}-${var.app}-cloudwatch-policy"
  path        = "/"
  description = "Cloudwatch logging policy for ${var.app}"
  policy      = data.aws_iam_policy_document.cloudwatch.json
}

resource "aws_iam_policy" "lambda_invoke" {
  name   = "${var.results}-${var.app}-invoke-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_invoke.json
}

resource "aws_iam_policy" "service_user_access" {
  name   = "${var.results}-${var.app}-service-user-access-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.service_user_access.json
}

resource "aws_iam_role_policy_attachment" "service_role_policies" {
  role       = aws_iam_role.lambda_service_role.name
  count      = length(var.invoke_policy_arn)
  policy_arn = var.invoke_policy_arn[count.index]
}

resource "aws_iam_policy" "s3_triggers_xacct" {
  name   = "${var.results}-${var.app}-s3-triggers-xacct-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_triggers_xacct.json
}
