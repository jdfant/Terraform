resource "aws_ssm_parameter" "db_host" {
  name      = "/${var.app}/${var.env}/db_host"
  type      = "String"
  value     = var.db_host
  overwrite = true
}

resource "aws_ssm_parameter" "db_name" {
  name      = "/${var.app}/${var.env}/db_name"
  type      = "String"
  value     = var.database_name
  overwrite = true
}

resource "aws_ssm_parameter" "db-master-password" {
  name   = "/${var.app}/${var.env}/master_password"
  type   = "SecureString"
  value  = var.password
  key_id = aws_kms_key.kms_key[0].id

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "db_access" {
  name      = "/${var.app}/${var.env}/db_access"
  type      = "String"
  value     = chomp(
<<-EOF
${aws_ssm_parameter.db_host.value},5432,${var.aws_iam_user},${aws_ssm_parameter.db_name.value},${var.region},(db_host,db_port,db_user,db_name,region)
EOF
)
  overwrite = true
}
