#################
Aurora RDS Module
#################

This leverages the AWS Aurora RDS, VPC, IAM, KMS, Cloudwatch, and SSM Terraform modules and performs the following functions:
-----------------------------------------------------------------------------------------------------------------------------
1. Creates base AWS environment, ie,. Security Groups and rules within existing VPC.
2. Creates IAM user, kms_key, and roles/policies necessary for Aurora DB access.
3. Apply "rds-db:connect" policy to IAM db user.
4. Creates Aurora Cluster, Aurora instance(s), Subnet Groups, Parameter Groups, Cloudwatch logging, and automatic snapshots (7 days).
5. Creates empty 'jd_aurora' database and local db user (random password) to grant IAM user access.
6. Creates and populates SSM "Parameter Store" providing up to date database details.
7. Ordered exactly as (db_host,db_port,db_user,db_name,region) to be parsed by external scripts for auto-logins.

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.autoscaling_read_replica_count](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.read_replica_count](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_db_parameter_group.aurora_db_postgres13_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.jd_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_access_key.iam_user_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.db_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.iam_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.rds_enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.rds_enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.rds_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_rds_cluster.jd_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.jd_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.aurora_cluster_postgres13_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [null_resource.db_setup](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.snapshot_identifier](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.db_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.monitoring_rds_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnet.jd_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.jd_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS Account ID | `number` | `null` | no |
| <a name="input_app"></a> [app](#input\_app) | prefix to be used on all the resources as a tag | `string` | `""` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Determines whether or not any DB modifications are applied immediately, or during the maintenance window | `bool` | `true` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Determines whether minor engine upgrades will be performed automatically in the maintenance window | `bool` | `true` | no |
| <a name="input_aws_iam_user"></a> [aws\_iam\_user](#input\_aws\_iam\_user) | The IAM user for RDS | `string` | `""` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | The target backtrack window, in seconds. Only available for aurora engine currently. Must be between 0 and 259200 (72 hours) | `number` | `0` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | How long to keep backups for (in days) | `number` | `null` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | The identifier of the CA certificate for the DB instance | `string` | `"rds-ca-2019"` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all Cluster tags to snapshots. | `bool` | `false` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Whether to create the IAM role for RDS enhanced monitoring | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name for an automatically created database on cluster creation | `string` | `""` | no |
| <a name="input_db_cluster_parameter_group_name"></a> [db\_cluster\_parameter\_group\_name](#input\_db\_cluster\_parameter\_group\_name) | The name of a DB Cluster parameter group to use | `string` | `""` | no |
| <a name="input_db_parameter_group"></a> [db\_parameter\_group](#input\_db\_parameter\_group) | This group acts as a container for engine configuration values that are applied to one or more DB instances. | `string` | `""` | no |
| <a name="input_db_parameter_group_name"></a> [db\_parameter\_group\_name](#input\_db\_parameter\_group\_name) | The name of a DB parameter group to use | `string` | `""` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | port for db traffic | `number` | `5432` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The existing subnet group name to use | `string` | `""` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled | `bool` | `false` | no |
| <a name="input_department"></a> [department](#input\_department) | departments for access level and expertise | `string` | `"devops"` | no |
| <a name="input_enable_http_endpoint"></a> [enable\_http\_endpoint](#input\_enable\_http\_endpoint) | Whether or not to enable the Data API for a serverless Aurora database engine. | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to export to cloudwatch | `list(string)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql | `string` | `"aurora-postgresql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. Valid values: global, parallelquery, provisioned, serverless, multimaster. | `string` | `"serverless"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Aurora database engine version. | `string` | `"13.6"` | no |
| <a name="input_env"></a> [env](#input\_env) | environment | `string` | `""` | no |
| <a name="input_family"></a> [family](#input\_family) | The family of the DB parameter group | `string` | `""` | no |
| <a name="input_final_snapshot_identifier_prefix"></a> [final\_snapshot\_identifier\_prefix](#input\_final\_snapshot\_identifier\_prefix) | The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too. | `string` | `"final"` | no |
| <a name="input_global_cluster_identifier"></a> [global\_cluster\_identifier](#input\_global\_cluster\_identifier) | The global cluster identifier specified on aws\_rds\_global\_cluster | `string` | `""` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether IAM Database authentication should be enabled or not. Refer to the AWS documentation to see which versions are supported. | `bool` | `true` | no |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | A List of ARNs for the IAM roles to associate to the RDS Cluster. | `list(string)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use at master instance. If instance\_type\_replica is not set it will use the same type for replica instances | `string` | `"db.serverless"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key if one is set to the cluster. | `string` | `""` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Master DB username | `string` | `"postgres"` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval (seconds) between points when Enhanced Monitoring metrics are collected | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Name given resources | `string` | `""` | no |
| <a name="input_parameter"></a> [parameter](#input\_parameter) | A list of Postgres DB parameter | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | <pre>[<br>  {<br>    "apply_method": "immediate",<br>    "name": "pgaudit.role",<br>    "value": "rds_pgaudit"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "pgaudit.log_statement_once",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "pgaudit.log_parameter",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "pgaudit.log_level",<br>    "value": "info"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "pgaudit.log",<br>    "value": "write, ddl, role"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "shared_preload_libraries",<br>    "value": "pgaudit"<br>  }<br>]</pre> | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `""` | no |
| <a name="input_predefined_metric_type"></a> [predefined\_metric\_type](#input\_predefined\_metric\_type) | The metric type to scale on. Valid values are RDSReaderAverageCPUUtilization and RDSReaderAverageDatabaseConnections. | `string` | `"RDSReaderAverageCPUUtilization"` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | When to perform DB backups | `string` | `"02:00-03:00"` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | When to perform DB maintenance | `string` | `"sun:05:00-sun:06:00"` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Whether the DB should have a public IP address | `bool` | `true` | no |
| <a name="input_rds_cluster_parameter_group"></a> [rds\_cluster\_parameter\_group](#input\_rds\_cluster\_parameter\_group) | This group acts as a container for engine configuration values that are applied to one or more DB instances. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-west-2"` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Number of reader nodes to create.  If `replica_scale_enable` is `true`, the value of `replica_scale_min` is used instead. | `number` | `1` | no |
| <a name="input_replica_scale_connections"></a> [replica\_scale\_connections](#input\_replica\_scale\_connections) | Average number of connections to trigger autoscaling at. Default value is 70% of db.r4.large's default max\_connections | `number` | `700` | no |
| <a name="input_replica_scale_cpu"></a> [replica\_scale\_cpu](#input\_replica\_scale\_cpu) | CPU usage to trigger autoscaling at | `number` | `70` | no |
| <a name="input_replica_scale_enabled"></a> [replica\_scale\_enabled](#input\_replica\_scale\_enabled) | Whether to enable autoscaling for RDS Aurora (MySQL) read replicas | `bool` | `false` | no |
| <a name="input_replica_scale_in_cooldown"></a> [replica\_scale\_in\_cooldown](#input\_replica\_scale\_in\_cooldown) | Cooldown in seconds before allowing further scaling operations after a scale in | `number` | `300` | no |
| <a name="input_replica_scale_max"></a> [replica\_scale\_max](#input\_replica\_scale\_max) | Maximum number of replicas to allow scaling for | `number` | `0` | no |
| <a name="input_replica_scale_min"></a> [replica\_scale\_min](#input\_replica\_scale\_min) | Minimum number of replicas to allow scaling for | `number` | `2` | no |
| <a name="input_replica_scale_out_cooldown"></a> [replica\_scale\_out\_cooldown](#input\_replica\_scale\_out\_cooldown) | Cooldown in seconds before allowing further scaling operations after a scale out | `number` | `300` | no |
| <a name="input_replication_source_identifier"></a> [replication\_source\_identifier](#input\_replication\_source\_identifier) | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. | `string` | `""` | no |
| <a name="input_scaling_configuration"></a> [scaling\_configuration](#input\_scaling\_configuration) | Map of nested attributes with scaling properties. Only valid when engine\_mode is set to `serverless` | `map(string)` | `{}` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Should a final snapshot be created on cluster destroy | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | DB snapshot to create this database from | `string` | `""` | no |
| <a name="input_source_region"></a> [source\_region](#input\_source\_region) | The source region for an encrypted replica DB cluster. | `string` | `""` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the underlying storage layer should be encrypted | `bool` | `true` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet IDs to use | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `""` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate to the cluster in addition to the SG we create in this module | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_caller_identity_current_account_id"></a> [aws\_caller\_identity\_current\_account\_id](#output\_aws\_caller\_identity\_current\_account\_id) | Account ID in which Terraform is working |
| <a name="output_jd_aurora_db_cluster_parameter_group_name"></a> [jd\_aurora\_db\_cluster\_parameter\_group\_name](#output\_jd\_aurora\_db\_cluster\_parameter\_group\_name) | Cluster Parameter Group Name |
| <a name="output_jd_aurora_db_parameter_group_name"></a> [jd\_aurora\_db\_parameter\_group\_name](#output\_jd\_aurora\_db\_parameter\_group\_name) | Instance Parameter Group Name |
| <a name="output_jd_aurora_rds_cluster_arn"></a> [jd\_aurora\_rds\_cluster\_arn](#output\_jd\_aurora\_rds\_cluster\_arn) | The ID of the cluster |
| <a name="output_jd_aurora_rds_cluster_aws_iam_user"></a> [jd\_aurora\_rds\_cluster\_aws\_iam\_user](#output\_jd\_aurora\_rds\_cluster\_aws\_iam\_user) | Name for jd\_aurora IAM User |
| <a name="output_jd_aurora_rds_cluster_database_name"></a> [jd\_aurora\_rds\_cluster\_database\_name](#output\_jd\_aurora\_rds\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_jd_aurora_rds_cluster_endpoint"></a> [jd\_aurora\_rds\_cluster\_endpoint](#output\_jd\_aurora\_rds\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_jd_aurora_rds_cluster_hosted_zone_id"></a> [jd\_aurora\_rds\_cluster\_hosted\_zone\_id](#output\_jd\_aurora\_rds\_cluster\_hosted\_zone\_id) | Route53 hosted zone id of the created cluster |
| <a name="output_jd_aurora_rds_cluster_id"></a> [jd\_aurora\_rds\_cluster\_id](#output\_jd\_aurora\_rds\_cluster\_id) | The ID of the cluster |
| <a name="output_jd_aurora_rds_cluster_instance_endpoints"></a> [jd\_aurora\_rds\_cluster\_instance\_endpoints](#output\_jd\_aurora\_rds\_cluster\_instance\_endpoints) | A list of all cluster instance endpoints |
| <a name="output_jd_aurora_rds_cluster_instance_ids"></a> [jd\_aurora\_rds\_cluster\_instance\_ids](#output\_jd\_aurora\_rds\_cluster\_instance\_ids) | A list of all cluster instance ids |
| <a name="output_jd_aurora_rds_cluster_master_password"></a> [jd\_aurora\_rds\_cluster\_master\_password](#output\_jd\_aurora\_rds\_cluster\_master\_password) | The master password |
| <a name="output_jd_aurora_rds_cluster_master_username"></a> [jd\_aurora\_rds\_cluster\_master\_username](#output\_jd\_aurora\_rds\_cluster\_master\_username) | The master username |
| <a name="output_jd_aurora_rds_cluster_port"></a> [jd\_aurora\_rds\_cluster\_port](#output\_jd\_aurora\_rds\_cluster\_port) | The port |
| <a name="output_jd_aurora_rds_cluster_reader_endpoint"></a> [jd\_aurora\_rds\_cluster\_reader\_endpoint](#output\_jd\_aurora\_rds\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_jd_aurora_rds_cluster_resource_id"></a> [jd\_aurora\_rds\_cluster\_resource\_id](#output\_jd\_aurora\_rds\_cluster\_resource\_id) | The Resource ID of the cluster |
<!-- END_TF_DOCS -->
