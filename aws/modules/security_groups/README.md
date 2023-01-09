<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | prefix to be used on all the resources as a tag | `any` | n/a | yes |
| <a name="input_azs"></a> [azs](#input\_azs) | A list of availability zones in the region | `list(string)` | <pre>[<br>  "us-west-2a",<br>  "us-west-2b",<br>  "us-west-2c"<br>]</pre> | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden | `string` | `"10.10.0.0/16"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | port for db traffic | `number` | `5432` | no |
| <a name="input_department"></a> [department](#input\_department) | departments for access level and expertise | `string` | `"devops"` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | enable\_nat\_gateway true or false | `bool` | `false` | no |
| <a name="input_enable_vpc_endpoints"></a> [enable\_vpc\_endpoints](#input\_enable\_vpc\_endpoints) | Set to true to enable vpc endpoints. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | environment | `string` | `""` | no |
| <a name="input_office_cidr"></a> [office\_cidr](#input\_office\_cidr) | cidr address to be added to SG, ssh as well http access will be granted | `list(string)` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of public subnets inside the VPC | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets inside the VPC | `list(string)` | n/a | yes |
| <a name="input_security_group_allowed_cidrs"></a> [security\_group\_allowed\_cidrs](#input\_security\_group\_allowed\_cidrs) | cidr address to be added to SG - for CROS - do not put office ip here | `list(string)` | n/a | yes |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The description of the security group. If value is set to empty string it will contain cluster name in the description. | `string` | `"Managed by Terraform"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | vpc cidr, will be added to sg for intra vpc communication | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID to use | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jd_aurora_security_group_id"></a> [jd\_aurora\_security\_group\_id](#output\_jd\_aurora\_security\_group\_id) | The security group ID of the cluster |
<!-- END_TF_DOCS -->
