<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_alias.kms_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.ssm_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_ssm_parameter.api_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ssm_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | API Gateway API Key | `string` | `""` | no |
| <a name="input_create_key"></a> [create\_key](#input\_create\_key) | Boolean to describe if key should be created or not | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key if one is set to the cluster | `string` | `""` | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Lambda Function Name | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name given resources | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to use | `string` | `""` | no |
| <a name="input_ssm_kms_key_alias"></a> [ssm\_kms\_key\_alias](#input\_ssm\_kms\_key\_alias) | KMS Key alias for SSM ParameterStore Secure String decryption | `string` | `""` | no |
| <a name="input_ssm_parameter_store_name"></a> [ssm\_parameter\_store\_name](#input\_ssm\_parameter\_store\_name) | Name of the SSM Parameter Store | `string` | `""` | no |
| <a name="input_ssm_parameter_store_type"></a> [ssm\_parameter\_store\_type](#input\_ssm\_parameter\_store\_type) | Type of the SSM Parameter Store | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | KMS Key ARN |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | KMS Key ID. |
| <a name="output_ssm_iam_policy_document"></a> [ssm\_iam\_policy\_document](#output\_ssm\_iam\_policy\_document) | SSM IAM Policy Document |
<!-- END_TF_DOCS -->