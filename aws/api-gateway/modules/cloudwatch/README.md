<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.kms_key_generator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Lambda Function Name | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_invoke_log_group_arn"></a> [lambda\_invoke\_log\_group\_arn](#output\_lambda\_invoke\_log\_group\_arn) | Lambda invoke cloudwatch group ARN. |
| <a name="output_lambda_invoke_log_group_name"></a> [lambda\_invoke\_log\_group\_name](#output\_lambda\_invoke\_log\_group\_name) | Lambda invoke cloudwatch group name. |
| <a name="output_log_group_arns"></a> [log\_group\_arns](#output\_log\_group\_arns) | List of cloudwatch group ARNs. |
<!-- END_TF_DOCS -->