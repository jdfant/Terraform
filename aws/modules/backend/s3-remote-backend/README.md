<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.bucket_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.bucket_full_access_with_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.remote_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.remote_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.s3_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.remote_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.remote_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy_document.bucket_full_access_with_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | prefix to be used on all the resources as a tag indicating the application name | `string` | n/a | yes |
| <a name="input_bucket_remote_backend_suffix"></a> [bucket\_remote\_backend\_suffix](#input\_bucket\_remote\_backend\_suffix) | the remote backend bucket name suffix | `string` | n/a | yes |
| <a name="input_department"></a> [department](#input\_department) | departments for access level and expertise | `string` | `"devops"` | no |
| <a name="input_enable_s3_bucket_policy"></a> [enable\_s3\_bucket\_policy](#input\_enable\_s3\_bucket\_policy) | creates IAM policy to access remote backend bucket | `bool` | `false` | no |
| <a name="input_enable_s3_bucket_policy_with_mfa"></a> [enable\_s3\_bucket\_policy\_with\_mfa](#input\_enable\_s3\_bucket\_policy\_with\_mfa) | creates IAM policy to access remote backend bucket that requires the user to have MFA enabled | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | environment | `string` | `""` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | list of user/role ARNs to get full access to the bucket | `list(string)` | n/a | yes |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | enables versioning for objects in the S3 bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of remote backend bucket. |
| <a name="output_bucket_full_access_policy_arn"></a> [bucket\_full\_access\_policy\_arn](#output\_bucket\_full\_access\_policy\_arn) | ARN of IAM policy that grants access to the bucket (without requiring MFA). |
| <a name="output_bucket_full_access_with_mfa_policy_arn"></a> [bucket\_full\_access\_with\_mfa\_policy\_arn](#output\_bucket\_full\_access\_with\_mfa\_policy\_arn) | ARN of IAM policy that grants access to the bucket (with MFA required). |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Id of remote backend bucket. |
| <a name="output_principals"></a> [principals](#output\_principals) | List of IAM user/role ARNs with access to the bucket. |
| <a name="output_region"></a> [region](#output\_region) | Region remote backend bucket created in. |
| <a name="output_url"></a> [url](#output\_url) | URL to the remote backend S3 bucket. |
<!-- END_TF_DOCS -->
