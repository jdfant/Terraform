## API Gateway REST API

Method Request:  
  - POST only w/API Key Required  

Integration Request:  
  - Integration type: Lambda Function  
  - Lambda Function: kms-key-generator  
  - Mapping Templates:  
#set($inputRoot = $input.path('$'))  
{\
  "Account": "$inputRoot.account",\
  "Region": "$inputRoot.region",\
  "KeyUsage": "$inputRoot.key_usage",\
  "KeyAlias": "$inputRoot.key_alias",\
  "KeyDescription": "$inputRoot.key_description"\
}

## Terraform Flow
1) Iam Policies/Roles:  
  a) KMS role/policies  
  b) API Gateway Resource Policy  
  c) Lambda execution role  

2) API Gateway (Regional Endpoint):  
  a) Method Request  
  b) Integration Request  
  c) Stages  
  d) Usage Plans  
  e) API Keys - API Key Source = Header  
  f) Client Certificate (internal - vxxxxxx)  
  g) SSL/TLS certs for encrypted api requests  

3) Lambda Function:  
  a) Function code  
  b) API Gateway trigger  

4) Cloudwatch   
  a) Log Group = /aws/lambda/kms-key-generator  

5) API request script  

6) SSM/ParameterStore  
  a) Path = /APIGateway/APIKeys/kms-key-generator  
  b) SecureString = xxxxxxxxxxxxxxxxxxxxxxxxxxxxx  

## 2Fix:
API key not being added to usage plan  
no API Gateway 'mapping templates'  
more verbose outputs  
set cloudwatch log group retention to never expire  
make parameter store api key content dynamic (no locals)  
no 'client certificate' in API Gateway 'Stage'  
```
.
├── README.md
├── domain_name.tf
├── graph.png
├── kms_key_generator.tf
├── locals.tf
├── outputs.tf
├── provider.tf
├── files
│   ├── api-request-sample-script.sh
│   ├── api_gateway_mapping_template.tpl
│   └── lambda_function.py
├── modules
│   ├── api_gateway
│   │   ├── README.md
│   │   ├── api_gateway.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── cloudwatch
│   │   ├── README.md
│   │   ├── log_group.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── lambda
│   │   ├── README.md
│   │   ├── lambda.tf
│   │   ├── outputs.tf
│   │   ├── policy.tf
│   │   ├── policy_data.tf
│   │   └── variables.tf
│   ├── remote_backend
│   │   ├── dynamodb-locking
│   │   │   ├── README.md
│   │   │   ├── dynamodb-locking.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── s3-remote-backend
│   │       ├── README.md
│   │       ├── outputs.tf
│   │       ├── policy.tf
│   │       ├── policy_data.tf
│   │       ├── s3_remote.tf
│   │       └── variables.tf
│   └── ssm
│       ├── README.md
│       ├── kms.tf
│       ├── outputs.tf
│       ├── parameter_store.tf
│       └── variables.tf
└── remote_backend
    ├── README.md
    ├── backend.tf
    ├── locals.tf
    └── main.tf
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | ./modules/api_gateway | n/a |
| <a name="module_cloudwatch"></a> [cloudwatch](#module\_cloudwatch) | ./modules/cloudwatch | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./modules/lambda | n/a |
| <a name="module_ssm"></a> [ssm](#module\_ssm) | ./modules/ssm | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_caller_identity_current_account_id"></a> [aws\_caller\_identity\_current\_account\_id](#output\_aws\_caller\_identity\_current\_account\_id) | Account ID in which Terraform is working |
| <a name="output_cloudwatch_log_group_arns"></a> [cloudwatch\_log\_group\_arns](#output\_cloudwatch\_log\_group\_arns) | List of cloudwatch log groups. |
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | ARN of execution role for lambda function. |
| <a name="output_execution_role_name"></a> [execution\_role\_name](#output\_execution\_role\_name) | Name of execution role for lambda function. |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | Function name of lambda function |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | ARN for lambda function. |
| <a name="output_ssm_kms_key_arn"></a> [ssm\_kms\_key\_arn](#output\_ssm\_kms\_key\_arn) | SSM KMS Key ARN |
<!-- END_TF_DOCS -->