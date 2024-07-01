variable "region" {
  description = "AWS Region"
  type        = string
  default     = ""
}

variable "source_account" {
  description = "AWS Account ID"
  type        = string
  default     = ""
}

variable "rest_api_name" {
  description = "AWS API Gateway Name"
  type        = string
  default     = ""
}

variable "rest_api_id" {
  description = "AWS API Gateway ID"
  type        = string
  default     = ""
}

variable "lambda_runtime" {
  description = "Valid Lambda Runtime"
  type        = string
  default     = ""
}

variable "lambda_timeout" {
  description = "Timeout for Lambda Function"
  type        = number
  default     = null
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

variable "lambda_function_handler" {
  description = "Lambda Function Name"
  type        = string
  default     = ""
}

variable "lambda_invoke_policy_arn" {
  description = "IAM Policy to be attached to role"
  type        = list(string)
}

variable "lambda_source_file" {
  description = "Lambda source file"
  type        = string
  default     = ""
}

variable "lambda_function_source_dir" {
  description = "Directory of files to be included in the lambda function zip file."
  type        = string
  default     = ""
}

variable "lambda_function_output_path" {
  description = "Lambda function zip files."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

# This is only for testing. 
variable "execution_allow_ip" {
  description = "Allowed IP for API Execution"
  type        = list(string)
  default     = []
}