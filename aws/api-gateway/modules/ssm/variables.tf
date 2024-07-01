variable "region" {
  description = "AWS region to use"
  type        = string
  default     = ""
}

variable "create_key" {
  description = "Boolean to describe if key should be created or not"
  default     = true
  type        = bool
}

variable "name" {
  description = "Name given resources"
  type        = string
  default     = ""
}

variable "api_key" {
  description = "API Gateway API Key"
  type        = string
  default     = ""
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key if one is set to the cluster"
  type        = string
  default     = ""
}

variable "ssm_kms_key_alias" {
  description = "KMS Key alias for SSM ParameterStore Secure String decryption"
  type        = string
  default     = ""
}

variable "ssm_parameter_store_name" {
  description = "Name of the SSM Parameter Store"
  type        = string
  default     = ""
}

variable "ssm_parameter_store_type" {
  description = "Type of the SSM Parameter Store"
  type        = string
  default     = ""
}

variable "lambda_function_name" {
  description = "Lambda Function Name"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}