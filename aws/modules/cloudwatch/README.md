<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.error_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.lambda_invoke_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | Prefix to be used on all the resources as a tag. | `string` | `""` | no |
| <a name="input_department"></a> [department](#input\_department) | departments for access level and expertise | `string` | `"devops"` | no |
| <a name="input_env"></a> [env](#input\_env) | environment | `string` | `""` | no |
| <a name="input_results"></a> [results](#input\_results) | Name of the 'results' | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_invoke_log_group_arn"></a> [lambda\_invoke\_log\_group\_arn](#output\_lambda\_invoke\_log\_group\_arn) | Lambda invoke cloudwatch group ARN. |
| <a name="output_lambda_invoke_log_group_name"></a> [lambda\_invoke\_log\_group\_name](#output\_lambda\_invoke\_log\_group\_name) | Lambda invoke cloudwatch group name. |
| <a name="output_log_group_arns"></a> [log\_group\_arns](#output\_log\_group\_arns) | List of cloudwatch group ARNs. |
<!-- END_TF_DOCS -->
