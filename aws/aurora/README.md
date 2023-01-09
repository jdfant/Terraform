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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ../modules/aurora | n/a |
| <a name="module_security_groups"></a> [security\_groups](#module\_security\_groups) | ../modules/security_groups | n/a |
| <a name="module_ssm"></a> [ssm](#module\_ssm) | ../modules/ssm | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_caller_identity_current_account_id"></a> [aws\_caller\_identity\_current\_account\_id](#output\_aws\_caller\_identity\_current\_account\_id) | Account ID in which Terraform is working |
| <a name="output_jd_aurora_rds_cluster_aws_iam_user"></a> [jd\_aurora\_rds\_cluster\_aws\_iam\_user](#output\_jd\_aurora\_rds\_cluster\_aws\_iam\_user) | Name for jd\_aurora IAM User |
| <a name="output_jd_aurora_rds_cluster_database_name"></a> [jd\_aurora\_rds\_cluster\_database\_name](#output\_jd\_aurora\_rds\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_jd_aurora_rds_cluster_endpoint"></a> [jd\_aurora\_rds\_cluster\_endpoint](#output\_jd\_aurora\_rds\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_jd_aurora_rds_cluster_id"></a> [jd\_aurora\_rds\_cluster\_id](#output\_jd\_aurora\_rds\_cluster\_id) | The ID of the cluster |
| <a name="output_jd_aurora_rds_cluster_instance_endpoints"></a> [jd\_aurora\_rds\_cluster\_instance\_endpoints](#output\_jd\_aurora\_rds\_cluster\_instance\_endpoints) | A list of all cluster instance endpoints |
| <a name="output_jd_aurora_rds_cluster_instance_ids"></a> [jd\_aurora\_rds\_cluster\_instance\_ids](#output\_jd\_aurora\_rds\_cluster\_instance\_ids) | A list of all cluster instance ids |
| <a name="output_jd_aurora_rds_cluster_master_password"></a> [jd\_aurora\_rds\_cluster\_master\_password](#output\_jd\_aurora\_rds\_cluster\_master\_password) | The master password |
| <a name="output_jd_aurora_rds_cluster_master_username"></a> [jd\_aurora\_rds\_cluster\_master\_username](#output\_jd\_aurora\_rds\_cluster\_master\_username) | The master username |
| <a name="output_jd_aurora_rds_cluster_port"></a> [jd\_aurora\_rds\_cluster\_port](#output\_jd\_aurora\_rds\_cluster\_port) | The port |
| <a name="output_jd_aurora_rds_cluster_reader_endpoint"></a> [jd\_aurora\_rds\_cluster\_reader\_endpoint](#output\_jd\_aurora\_rds\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_jd_aurora_rds_cluster_resource_id"></a> [jd\_aurora\_rds\_cluster\_resource\_id](#output\_jd\_aurora\_rds\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_jd_aurora_security_group_id"></a> [jd\_aurora\_security\_group\_id](#output\_jd\_aurora\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | KMS Key ARN |
<!-- END_TF_DOCS -->