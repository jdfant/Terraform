<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.kms_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_ssm_parameter.db-master-password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.db_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.db_host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.db_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | Prefix to be used on all the resources as a tag. | `any` | n/a | yes |
| <a name="input_aws_iam_user"></a> [aws\_iam\_user](#input\_aws\_iam\_user) | The IAM user for RDS | `string` | n/a | yes |
| <a name="input_create_key"></a> [create\_key](#input\_create\_key) | Boolean to describe if key should be created or not | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name for an automatically created database on cluster creation | `string` | `""` | no |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | DB Hostname | `string` | `""` | no |
| <a name="input_department"></a> [department](#input\_department) | departments for access level and expertise | `string` | `"devops"` | no |
| <a name="input_env"></a> [env](#input\_env) | environment | `string` | `""` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key if one is set to the cluster. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name given resources | `string` | `""` | no |
| <a name="input_password"></a> [password](#input\_password) | Master DB password | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to use | `string` | `"us-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | KMS Key ARN |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | KMS Key ID. |
<!-- END_TF_DOCS -->