/*
variable "aws_api_gateway_rest_api_id" {
  description = "AWS API Gateway REST API ID"
  type        = string
}
variable "api_gateway_resource_path" {
  description = "AWS API Gateway Resource Path"
  type        = string
}
*/

variable "region" {
  description = "AWS Region"
  type        = string
  default     = ""
}

variable "account" {
  description = "AWS Account ID"
  type        = string
  default     = ""
}

variable "rest_api_name" {
  description = "AWS API Gateway Name"
  type        = string
  default     = ""
}

variable "api_gateway_stage_name" {
  description = "API Gateway Stage Name"
  type        = string
  default     = ""
}

variable "integration_http_method" {
  description = "API Gateway Integration Method"
  type        = string
  default     = ""
}

variable "api_key_required" {
  description = "API Key Required?"
  type        = bool
  default     = true
}

variable "api_gateway_authorization" {
  description = "API Gateway Auhorization Method"
  type        = string
  default     = ""
}

variable "api_gateway_integration_type" {
  description = "API Gateway Integration input's type"
  type        = string
  default     = ""
}

variable "endpoint_configuration_type" {
  description = "API endpoint configuration"
  type        = list(string)
  default     = []
}

variable "endpoint_path" {
  description = "AWS API Gateway REST API Endpoint Path"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "ARN for lambda function."
  type        = string
}

variable "path_part" {
  description = "Last path segment of this API resource"
  type        = string
  default     = ""
}

variable "lambda_function_name" {
  description = "Lambda Function Name"
  type        = string
  default     = ""
}

variable "lambda_function_source_dir" {
  description = "Directory of files to be included in the lambda function zip file."
  type        = string
  default     = ""
}

variable "lambda_function_output_path" {
  description = "Directory containing the lambda function zip files."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

# This is only for testing.
variable "api_execution_source_ip" {
  description = "Allowed IP for API Execution"
  type        = list(string)
  default     = []
}