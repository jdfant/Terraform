variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = number
  default     = null
}

variable "app" {
  description = "prefix to be used on all the resources as a tag"
  type        = string
  default     = ""
}

variable "env" {
  description = "environment"
  type        = string
  default     = ""
  validation {
    condition = contains([
      "prod",
      "stage",
      "dev",
      "test",
    ], var.env)
    error_message = "The env entered is not allowed, please use the correct env"
  }
}

variable "department" {
  description = "departments for access level and expertise"
  type        = string
  default     = "devops"
  validation {
    condition = contains([
      "devops",
      "devsecops",
      "sre",
      "powerdev",
      "dev",
      "intern",
    ], var.department)
    error_message = "The department entered is not allowed, please use the correct department."
  }
}

variable "name" {
  description = "Name given resources"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "List of subnet IDs to use"
  type        = list(string)
  default     = []
}

variable "replica_count" {
  description = "Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead."
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}


variable "publicly_accessible" {
  description = "Whether the DB should have a public IP address"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = ""
}

variable "master_username" {
  description = "Master DB username"
  type        = string
  default     = "postgres"
}

variable "final_snapshot_identifier_prefix" {
  description = "The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too."
  type        = string
  default     = "final"
}

variable "skip_final_snapshot" {
  description = "Should a final snapshot be created on cluster destroy"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = false
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = ""
}

variable "db_parameter_group" {
  description = "This group acts as a container for engine configuration values that are applied to one or more DB instances."
  type        = string
  default     = ""
}

variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  type        = number
  default     = null
}

variable "preferred_backup_window" {
  description = "When to perform DB backups"
  type        = string
  default     = "02:00-03:00"
}

variable "preferred_maintenance_window" {
  description = "When to perform DB maintenance"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "apply_immediately" {
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
  type        = bool
  default     = true
}

variable "create_monitoring_role" {
  description = "Whether to create the IAM role for RDS enhanced monitoring"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "The interval (seconds) between points when Enhanced Monitoring metrics are collected"
  type        = number
  default     = 0
}

variable "auto_minor_version_upgrade" {
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
  type        = bool
  default     = true
}

variable "db_parameter_group_name" {
  description = "The name of a DB parameter group to use"
  type        = string
  default     = ""
}

variable "db_cluster_parameter_group_name" {
  description = "The name of a DB Cluster parameter group to use"
  type        = string
  default     = ""
}

variable "scaling_configuration" {
  description = "Map of nested attributes with scaling properties. Only valid when engine_mode is set to `serverless`"
  type        = map(string)
  default     = {}
}

variable "snapshot_identifier" {
  description = "DB snapshot to create this database from"
  type        = string
  default     = ""
}

variable "storage_encrypted" {
  description = "Specifies whether the underlying storage layer should be encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key if one is set to the cluster."
  type        = string
  default     = ""
}

variable "engine" {
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version" {
  description = "Aurora database engine version."
  type        = string
  default     = "13.6"
}

variable "instance_type" {
  description = "Instance type to use at master instance. If instance_type_replica is not set it will use the same type for replica instances"
  type        = string
  default     = "db.serverless"
}

variable "enable_http_endpoint" {
  description = "Whether or not to enable the Data API for a serverless Aurora database engine."
  type        = bool
  default     = false
}

variable "replica_scale_enabled" {
  description = "Whether to enable autoscaling for RDS Aurora (MySQL) read replicas"
  type        = bool
  default     = false
}

variable "replica_scale_max" {
  description = "Maximum number of replicas to allow scaling for"
  type        = number
  default     = 0
}

variable "replica_scale_min" {
  description = "Minimum number of replicas to allow scaling for"
  type        = number
  default     = 2
}

variable "replica_scale_cpu" {
  description = "CPU usage to trigger autoscaling at"
  type        = number
  default     = 70
}

variable "replica_scale_connections" {
  description = "Average number of connections to trigger autoscaling at. Default value is 70% of db.r4.large's default max_connections"
  type        = number
  default     = 700
}

variable "replica_scale_in_cooldown" {
  description = "Cooldown in seconds before allowing further scaling operations after a scale in"
  type        = number
  default     = 300
}

variable "replica_scale_out_cooldown" {
  description = "Cooldown in seconds before allowing further scaling operations after a scale out"
  type        = number
  default     = 300
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether IAM Database authentication should be enabled or not. Refer to the AWS documentation to see which versions are supported."
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to cloudwatch"
  type        = list(string)
  default     = []
}

variable "global_cluster_identifier" {
  description = "The global cluster identifier specified on aws_rds_global_cluster"
  type        = string
  default     = ""
}

variable "engine_mode" {
  description = "The database engine mode. Valid values: global, parallelquery, provisioned, serverless, multimaster."
  type        = string
  default     = "serverless"
}

variable "replication_source_identifier" {
  description = "ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica."
  type        = string
  default     = ""
}

variable "source_region" {
  description = "The source region for an encrypted replica DB cluster."
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate to the cluster in addition to the SG we create in this module"
  type        = list(string)
  default     = []
}

variable "db_port" {
  description = "port for db traffic"
  type        = number
  default     = 5432
}

variable "db_subnet_group_name" {
  description = "The existing subnet group name to use"
  type        = string
  default     = ""
}

variable "predefined_metric_type" {
  description = "The metric type to scale on. Valid values are RDSReaderAverageCPUUtilization and RDSReaderAverageDatabaseConnections."
  type        = string
  default     = "RDSReaderAverageCPUUtilization"
}

variable "backtrack_window" {
  description = "The target backtrack window, in seconds. Only available for aurora engine currently. Must be between 0 and 259200 (72 hours)"
  type        = number
  default     = 0
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster tags to snapshots."
  type        = bool
  default     = false
}

variable "iam_roles" {
  description = "A List of ARNs for the IAM roles to associate to the RDS Cluster."
  type        = list(string)
  default     = []
}

variable "aws_iam_user" {
  description = "The IAM user for RDS"
  type        = string
  default     = ""
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = ""
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance"
  type        = string
  default     = "rds-ca-2019"
}

variable "rds_cluster_parameter_group" {
  description = "This group acts as a container for engine configuration values that are applied to one or more DB instances."
  type        = string
  default     = ""
}

variable "parameter" {
  description = "A list of Postgres DB parameter"
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
  default = [
    {
      name         = "pgaudit.role"
      value        = "rds_pgaudit"
      apply_method = "immediate"
    },
    {
      name         = "pgaudit.log_statement_once"
      value        = "1"
      apply_method = "immediate"
    },
    {
      name         = "pgaudit.log_parameter"
      value        = "1"
      apply_method = "immediate"
    },
    {
      name         = "pgaudit.log_level"
      value        = "info"
      apply_method = "immediate"
    },
    {
      name         = "pgaudit.log"
      value        = "write, ddl, role"
      apply_method = "immediate"
    },
    {
      name         = "shared_preload_libraries"
      value        = "pgaudit"
      apply_method = "pending-reboot"
    },
  ]
  validation {
    condition = length([
      for parameter in var.parameter : true
      if contains(["immediate", "pending-reboot"], parameter.apply_method)
    ]) == length(var.parameter)
    error_message = "Parameter apply_method can only be immediate or pending-reboot."
  }
}
