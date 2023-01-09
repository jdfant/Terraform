resource "aws_security_group" "rds_sg" {
  name        = "${var.app}-rds-sg"
  description = "db port in"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    self        = true
    cidr_blocks = concat(var.security_group_allowed_cidrs, var.vpc_cidr, var.office_cidr)
    description = var.security_group_description
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.app}-rds-sg"
    App         = var.app
    Environment = var.env
    Terraformed = "true"
    Department  = var.department
  }
}
