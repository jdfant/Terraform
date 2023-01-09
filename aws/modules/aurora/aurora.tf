resource "aws_rds_cluster" "jd_aurora" {
  global_cluster_identifier           = var.global_cluster_identifier
  cluster_identifier                  = var.name
  replication_source_identifier       = var.replication_source_identifier
  source_region                       = var.source_region
  engine                              = var.engine
  engine_mode                         = var.engine_mode
  engine_version                      = var.engine_version
  enable_http_endpoint                = var.enable_http_endpoint
  kms_key_id                          = var.kms_key_id
  database_name                       = var.database_name
  master_username                     = var.master_username
  master_password                     = random_password.master_password.result
  final_snapshot_identifier           = "${var.final_snapshot_identifier_prefix}-${var.name}-${random_id.snapshot_identifier.hex}"
  skip_final_snapshot                 = var.skip_final_snapshot
  deletion_protection                 = var.deletion_protection
  backup_retention_period             = var.backup_retention_period
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  port                                = var.db_port
  db_subnet_group_name                = var.name
  vpc_security_group_ids              = var.vpc_security_group_ids
  snapshot_identifier                 = var.snapshot_identifier
  storage_encrypted                   = var.storage_encrypted
  apply_immediately                   = var.apply_immediately
  db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  backtrack_window                    = var.backtrack_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  iam_roles                           = var.iam_roles
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports

  dynamic "scaling_configuration" {
    for_each = length(keys(var.scaling_configuration)) == 0 ? [] : [var.scaling_configuration]

    content {
      auto_pause               = lookup(scaling_configuration.value, "auto_pause", null)
      max_capacity             = lookup(scaling_configuration.value, "max_capacity", null)
      min_capacity             = lookup(scaling_configuration.value, "min_capacity", null)
      seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause", null)
      timeout_action           = lookup(scaling_configuration.value, "timeout_action", null)
    }
  }

  tags = var.tags
}

resource "aws_rds_cluster_instance" "jd_aurora" {
  count = var.replica_scale_enabled ? var.replica_scale_min : var.replica_count

  identifier                   = "${var.name}-${count.index + 1}"
  cluster_identifier           = aws_rds_cluster.jd_aurora.id
  engine                       = aws_rds_cluster.jd_aurora.engine
  engine_version               = aws_rds_cluster.jd_aurora.engine_version
  instance_class               = var.instance_type
  publicly_accessible          = var.publicly_accessible
  db_subnet_group_name         = var.name
  db_parameter_group_name      = var.db_parameter_group_name
  preferred_maintenance_window = var.preferred_maintenance_window
  apply_immediately            = var.apply_immediately
  monitoring_interval          = var.monitoring_interval
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  ca_cert_identifier           = var.ca_cert_identifier
  tags                         = var.tags
}

resource "aws_db_parameter_group" "aurora_db_postgres13_parameter_group" {
  name        = var.db_parameter_group
  family      = var.family
  description = "aurora-db-postgres1r-parameter-group"

  dynamic "parameter" {
    for_each = var.parameter
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres13_parameter_group" {
  name        = var.rds_cluster_parameter_group
  family      = var.family
  description = "aurora-postgres13-cluster-parameter-group"
}

resource "random_id" "snapshot_identifier" {
  keepers = {
    id = var.name
  }

  byte_length = 4
}

resource "aws_iam_user" "iam_user" {
  name = var.aws_iam_user
}

resource "aws_iam_access_key" "iam_user_key" {
  user = aws_iam_user.iam_user.name
}

resource "aws_appautoscaling_target" "read_replica_count" {
  count = var.replica_scale_enabled ? 1 : 0

  max_capacity       = var.replica_scale_max
  min_capacity       = var.replica_scale_min
  resource_id        = "cluster:${aws_rds_cluster.jd_aurora.cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"
}

resource "aws_appautoscaling_policy" "autoscaling_read_replica_count" {
  count = var.replica_scale_enabled ? 1 : 0

  name               = "target-metric"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "cluster:${aws_rds_cluster.jd_aurora.cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    scale_in_cooldown  = var.replica_scale_in_cooldown
    scale_out_cooldown = var.replica_scale_out_cooldown
    target_value       = var.predefined_metric_type == "RDSReaderAverageCPUUtilization" ? var.replica_scale_cpu : var.replica_scale_connections
  }

  depends_on = [aws_appautoscaling_target.read_replica_count]
}

resource "random_password" "master_password" {
  length  = 16
  special = false
}

data "aws_subnets" "jd_aurora" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "jd_aurora" {
  for_each = toset(data.aws_subnets.jd_aurora.ids)
  id       = each.value
}

resource "aws_db_subnet_group" "jd_aurora" {
  count = var.db_subnet_group_name == "" ? 1 : 0

  name        = var.name
  description = "For Aurora cluster ${var.name}"
  subnet_ids  = var.subnets

  tags = merge(var.tags, {
    Name = var.name
  })
}

data "aws_caller_identity" "current" {
}

# Thinking of leveraging Ansible for this. Stay tuned!
# This just creates an empty 'jd_aurora' database and local db user (random password) to grant IAM user access.
resource "null_resource" "db_setup" {
  depends_on = [aws_rds_cluster.jd_aurora]

  provisioner "local-exec" {
    command = join(" ", ["PGPASSWORD=${random_password.master_password.result}",
      "psql",
      "-h ${aws_rds_cluster.jd_aurora.endpoint}",
      "-p 5432",
      "-d ${aws_rds_cluster.jd_aurora.database_name}",
      "-U ${aws_rds_cluster.jd_aurora.master_username}",
      "-c 'CREATE USER ${aws_iam_user.iam_user.name}'",
      "-c 'GRANT rds_iam TO ${aws_iam_user.iam_user.name}'",
      "-c 'GRANT rds_iam TO ${aws_rds_cluster.jd_aurora.master_username}'",
      "-c 'CREATE ROLE readonly'",
      "-c 'GRANT USAGE ON SCHEMA public TO readonly'",
      "-c 'GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly'",
      "-c 'CREATE ROLE lambda'",
      "-c 'GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO lambda'",
      "-c 'GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO lambda'",
      "-c 'GRANT lambda TO ${aws_iam_user.iam_user.name}'",
      "-c 'CREATE ROLE admin'",
      "-c 'GRANT postgres to admin;'"])

    environment = {
      PGPASSWORD = random_password.master_password.result
    }
  }
}
