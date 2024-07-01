<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_deployment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_integration.lambda_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_method.post_method](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_resource.kms_key_generator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_rest_api.kms_key_generator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_rest_api_policy.kms_key_generator_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api_policy) | resource |
| [aws_api_gateway_stage.kms_key_generator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms_key_generator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | AWS Account ID | `string` | `""` | no |
| <a name="input_api_execution_source_ip"></a> [api\_execution\_source\_ip](#input\_api\_execution\_source\_ip) | Allowed IP for API Execution | `list(string)` | `[]` | no |
| <a name="input_api_gateway_authorization"></a> [api\_gateway\_authorization](#input\_api\_gateway\_authorization) | API Gateway Auhorization Method | `string` | `""` | no |
| <a name="input_api_gateway_integration_type"></a> [api\_gateway\_integration\_type](#input\_api\_gateway\_integration\_type) | API Gateway Integration input's type | `string` | `""` | no |
| <a name="input_api_gateway_stage_name"></a> [api\_gateway\_stage\_name](#input\_api\_gateway\_stage\_name) | API Gateway Stage Name | `string` | `""` | no |
| <a name="input_api_key_required"></a> [api\_key\_required](#input\_api\_key\_required) | API Key Required? | `bool` | `true` | no |
| <a name="input_endpoint_configuration_type"></a> [endpoint\_configuration\_type](#input\_endpoint\_configuration\_type) | API endpoint configuration | `list(string)` | `[]` | no |
| <a name="input_endpoint_path"></a> [endpoint\_path](#input\_endpoint\_path) | AWS API Gateway REST API Endpoint Path | `string` | n/a | yes |
| <a name="input_integration_http_method"></a> [integration\_http\_method](#input\_integration\_http\_method) | API Gateway Integration Method | `string` | `""` | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Lambda Function Name | `string` | `""` | no |
| <a name="input_lambda_function_output_path"></a> [lambda\_function\_output\_path](#input\_lambda\_function\_output\_path) | Directory containing the lambda function zip files. | `string` | `""` | no |
| <a name="input_lambda_function_source_dir"></a> [lambda\_function\_source\_dir](#input\_lambda\_function\_source\_dir) | Directory of files to be included in the lambda function zip file. | `string` | `""` | no |
| <a name="input_lambda_invoke_arn"></a> [lambda\_invoke\_arn](#input\_lambda\_invoke\_arn) | ARN for lambda function. | `string` | n/a | yes |
| <a name="input_path_part"></a> [path\_part](#input\_path\_part) | Last path segment of this API resource | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `""` | no |
| <a name="input_rest_api_name"></a> [rest\_api\_name](#input\_rest\_api\_name) | AWS API Gateway Name | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_caller_identity_current_account_id"></a> [aws\_caller\_identity\_current\_account\_id](#output\_aws\_caller\_identity\_current\_account\_id) | Account ID in which Terraform is working |
| <a name="output_rest_api_id"></a> [rest\_api\_id](#output\_rest\_api\_id) | n/a |
<!-- END_TF_DOCS -->