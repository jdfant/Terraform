<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.service_role_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.kms_key_generator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.kms_key_generator_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [archive_file.lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_execution_allow_ip"></a> [execution\_allow\_ip](#input\_execution\_allow\_ip) | Allowed IP for API Execution | `list(string)` | `[]` | no |
| <a name="input_lambda_function_handler"></a> [lambda\_function\_handler](#input\_lambda\_function\_handler) | Lambda Function Name | `string` | `""` | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Lambda Function Name | `string` | `""` | no |
| <a name="input_lambda_function_output_path"></a> [lambda\_function\_output\_path](#input\_lambda\_function\_output\_path) | Lambda function zip files. | `string` | `""` | no |
| <a name="input_lambda_function_source_dir"></a> [lambda\_function\_source\_dir](#input\_lambda\_function\_source\_dir) | Directory of files to be included in the lambda function zip file. | `string` | `""` | no |
| <a name="input_lambda_invoke_policy_arn"></a> [lambda\_invoke\_policy\_arn](#input\_lambda\_invoke\_policy\_arn) | IAM Policy to be attached to role | `list(string)` | n/a | yes |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | Valid Lambda Runtime | `string` | `""` | no |
| <a name="input_lambda_source_file"></a> [lambda\_source\_file](#input\_lambda\_source\_file) | Lambda source file | `string` | `""` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | Timeout for Lambda Function | `number` | `null` | no |
| <a name="input_path_part"></a> [path\_part](#input\_path\_part) | Last path segment of this API resource | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `""` | no |
| <a name="input_rest_api_id"></a> [rest\_api\_id](#input\_rest\_api\_id) | AWS API Gateway ID | `string` | `""` | no |
| <a name="input_rest_api_name"></a> [rest\_api\_name](#input\_rest\_api\_name) | AWS API Gateway Name | `string` | `""` | no |
| <a name="input_source_account"></a> [source\_account](#input\_source\_account) | AWS Account ID | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | Execution Role ARN |
| <a name="output_execution_role_name"></a> [execution\_role\_name](#output\_execution\_role\_name) | Execution Role Name |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | Name of lambda function |
| <a name="output_lambda_invoke_arn"></a> [lambda\_invoke\_arn](#output\_lambda\_invoke\_arn) | Invocation ARN for lambda function |
<!-- END_TF_DOCS -->