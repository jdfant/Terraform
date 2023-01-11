<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_triggers_xacct](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service_user_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.service_role_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_alias.lambda_alias_stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_layer_version.lambda_layer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_lambda_permission.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_object.lambda_function_upload](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.lambda_layer_upload](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [archive_file.lambda_function_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [archive_file.lambda_layer_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_triggers_xacct](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.service_user_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lambda_invocation.invocation_test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lambda_invocation) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_file.lambda_payload](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | Prefix for identification purposes. | `string` | n/a | yes |
| <a name="input_db_access"></a> [db\_access](#input\_db\_access) | SSM Parameter Store for DB credentials | `string` | n/a | yes |
| <a name="input_department"></a> [department](#input\_department) | departments for access level and expertise | `string` | `"devops"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of lambda function. | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | environment | `string` | `""` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | Map of environment variables. | `map(string)` | `null` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Function handler to lambda function. | `string` | n/a | yes |
| <a name="input_invoke_policy_arn"></a> [invoke\_policy\_arn](#input\_invoke\_policy\_arn) | IAM Policy to be attached to role | `list(string)` | n/a | yes |
| <a name="input_lambda_alias"></a> [lambda\_alias](#input\_lambda\_alias) | Lambda alias name | `string` | n/a | yes |
| <a name="input_lambda_function_output_path"></a> [lambda\_function\_output\_path](#input\_lambda\_function\_output\_path) | Directory containing the lambda function zip files. | `string` | n/a | yes |
| <a name="input_lambda_function_source_dir"></a> [lambda\_function\_source\_dir](#input\_lambda\_function\_source\_dir) | Directory of files to be included in the lambda function zip file. | `string` | n/a | yes |
| <a name="input_lambda_layer_output_path"></a> [lambda\_layer\_output\_path](#input\_lambda\_layer\_output\_path) | Directory containing the lambda layer zip files. | `string` | n/a | yes |
| <a name="input_lambda_layer_source_dir"></a> [lambda\_layer\_source\_dir](#input\_lambda\_layer\_source\_dir) | Directory of files to be included in the lambda layer zip file. | `string` | n/a | yes |
| <a name="input_lambda_payload"></a> [lambda\_payload](#input\_lambda\_payload) | Lambda Payload File | `string` | n/a | yes |
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | Name of the lambda layer. | `string` | `null` | no |
| <a name="input_layer_runtime"></a> [layer\_runtime](#input\_layer\_runtime) | Valid lambda layer runtime. | `string` | n/a | yes |
| <a name="input_layers"></a> [layers](#input\_layers) | List of lambda layer arns. | `list(string)` | `null` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Size of memory in MB. | `number` | `null` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Set to true to publish lambda function as a new version. | `bool` | `null` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | Amount of reserved concurrent executions | `number` | `null` | no |
| <a name="input_results"></a> [results](#input\_results) | Name of the 'results' | `string` | `""` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Valid lambda runtime. | `string` | n/a | yes |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 Bucket to push/store lambdas. | `string` | `null` | no |
| <a name="input_s3_key_function"></a> [s3\_key\_function](#input\_s3\_key\_function) | S3 key of an object containing the lambda function. | `string` | `null` | no |
| <a name="input_s3_key_layer"></a> [s3\_key\_layer](#input\_s3\_key\_layer) | S3 key of an object containing the lambda layer. | `string` | `null` | no |
| <a name="input_s3_lambda_notifications"></a> [s3\_lambda\_notifications](#input\_s3\_lambda\_notifications) | Map of s3 lambda notifications variables. | `map(any)` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security Groups configured on the same VPC as the subnets. | `list(string)` | `null` | no |
| <a name="input_source_account"></a> [source\_account](#input\_source\_account) | Account for Cross Account actions | `number` | n/a | yes |
| <a name="input_source_arn"></a> [source\_arn](#input\_source\_arn) | S3 Bucket arn for applying lambda permissions | `set(string)` | n/a | yes |
| <a name="input_stage_alias"></a> [stage\_alias](#input\_stage\_alias) | Lambda version number to point STAGE alias | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs for VPC configuration. Must specify security group ids if using. | `list(string)` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout for lambda function. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | ARN of execution role for lambda function. |
| <a name="output_execution_role_name"></a> [execution\_role\_name](#output\_execution\_role\_name) | Name of execution role for lambda function. |
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | Function arn of lambda function |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | Function name of lambda function |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | Invocation ARN for lambda function. |
| <a name="output_lambda_alias"></a> [lambda\_alias](#output\_lambda\_alias) | Name of the lambda layer(s). |
| <a name="output_lambda_function_source_dir"></a> [lambda\_function\_source\_dir](#output\_lambda\_function\_source\_dir) | Directory containing files to be added to the Lambda function zip file |
| <a name="output_lambda_latest_version"></a> [lambda\_latest\_version](#output\_lambda\_latest\_version) | Latest version of the lambda |
| <a name="output_lambda_layer_source_dir"></a> [lambda\_layer\_source\_dir](#output\_lambda\_layer\_source\_dir) | Directory containing files to be added to the Lambda layer zip file |
| <a name="output_lambda_layers"></a> [lambda\_layers](#output\_lambda\_layers) | Name of the lambda layer(s). |
| <a name="output_s3_bucket_object_key"></a> [s3\_bucket\_object\_key](#output\_s3\_bucket\_object\_key) | The key of the S3 bucket upload bject. |
| <a name="output_s3_bucket_object_version"></a> [s3\_bucket\_object\_version](#output\_s3\_bucket\_object\_version) | The version of the S3 bucket upload oject. |
| <a name="output_s3_bucket_upload_name"></a> [s3\_bucket\_upload\_name](#output\_s3\_bucket\_upload\_name) | Name of S3 upload bucket. |
| <a name="output_s3_bucket_upload_source"></a> [s3\_bucket\_upload\_source](#output\_s3\_bucket\_upload\_source) | Source for the S3 upload. |
<!-- END_TF_DOCS -->
