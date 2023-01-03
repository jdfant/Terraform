data "aws_partition" "current" {}

resource "aws_dynamodb_table" "dynamodb_terraform_state_lock" {
  name           = "${var.app}-${var.env}-terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.app}-${var.env}-terraform-state-lock-dynamo"
    App         = var.app
    Env         = var.env
    Department  = var.department
    Terraformed = "true"
  }
}

data "aws_iam_policy_document" "dynamodb_access" {
  statement {
    sid    = "DynamoDBAccess"
    effect = "Allow"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]

    resources = ["arn:${data.aws_partition.current.partition}:dynamodb:*:*:table/${aws_dynamodb_table.dynamodb_terraform_state_lock.name}"]
  }
}

resource "aws_iam_policy" "dynamo_state_locking" {
  name        = aws_dynamodb_table.dynamodb_terraform_state_lock.name
  description = "DynamoDB permissions for terraform state file"
  path        = "/"  
  policy      = data.aws_iam_policy_document.dynamodb_access.json
}
