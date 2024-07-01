<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.bucket_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.remote_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.remote_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.s3_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.remote_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_remote_backend_suffix"></a> [bucket\_remote\_backend\_suffix](#input\_bucket\_remote\_backend\_suffix) | the remote backend bucket name suffix | `string` | n/a | yes |
| <a name="input_enable_s3_bucket_policy"></a> [enable\_s3\_bucket\_policy](#input\_enable\_s3\_bucket\_policy) | creates IAM policy to access remote backend bucket | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | prefix to be used on all the resources as a tag indicating the bucket name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of remote backend bucket. |
| <a name="output_bucket_full_access_policy_arn"></a> [bucket\_full\_access\_policy\_arn](#output\_bucket\_full\_access\_policy\_arn) | ARN of IAM policy that grants access to the bucket. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Id of remote backend bucket. |
| <a name="output_region"></a> [region](#output\_region) | Region remote backend bucket created in. |
| <a name="output_url"></a> [url](#output\_url) | URL to the remote backend S3 bucket. |
<!-- END_TF_DOCS -->