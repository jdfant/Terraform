resource "aws_iam_policy" "iam_user_policy" {
  name        = "${aws_iam_user.iam_user.name}-policy"
  path        = "/"
  description = "IAM DB User connect policy"
  policy      = data.aws_iam_policy_document.iam_user_policy.json
}

resource "aws_iam_policy" "db_access_policy" {
  name   = "${aws_iam_user.iam_user.name}-access-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.db_access_policy.json
}

resource "aws_iam_role" "rds_enhanced_monitoring" {
  count = var.create_monitoring_role && var.monitoring_interval > 0 ? 1 : 0

  name               = "rds-enhanced-monitoring-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.monitoring_rds_assume_role.json

  permissions_boundary = var.permissions_boundary

  tags = merge(var.tags, {
    Name = aws_iam_user.iam_user.name
  })
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  count = var.create_monitoring_role && var.monitoring_interval > 0 ? 1 : 0

  role       = aws_iam_role.rds_enhanced_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_iam_user_policy_attachment" "rds_attach" {
  user       = aws_iam_user.iam_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}