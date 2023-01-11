<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch"></a> [cloudwatch](#module\_cloudwatch) | ../modules/cloudwatch | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ../modules/lambda | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_arns"></a> [cloudwatch\_log\_group\_arns](#output\_cloudwatch\_log\_group\_arns) | List of cloudwatch log groups. |
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | ARN of execution role for lambda function. |
| <a name="output_execution_role_name"></a> [execution\_role\_name](#output\_execution\_role\_name) | Name of execution role for lambda function. |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | Function name of lambda function |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | Invocation ARN for lambda function. |
| <a name="output_lambda_alias"></a> [lambda\_alias](#output\_lambda\_alias) | Lambda Alias |
| <a name="output_lambda_latest_version"></a> [lambda\_latest\_version](#output\_lambda\_latest\_version) | Lambda 'latest'version number |
| <a name="output_lambda_layers"></a> [lambda\_layers](#output\_lambda\_layers) | Name of the lambda layer(s). |
| <a name="output_s3_bucket_object_key"></a> [s3\_bucket\_object\_key](#output\_s3\_bucket\_object\_key) | The key of the S3 bucket upload object. |
| <a name="output_s3_bucket_upload_name"></a> [s3\_bucket\_upload\_name](#output\_s3\_bucket\_upload\_name) | Name of S3 upload bucket. |
<!-- END_TF_DOCS -->
