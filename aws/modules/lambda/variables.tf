variable "app" {
  description = "Prefix for identification purposes."
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
  default     = ""
  validation {
    condition = contains([
      "prod",
      "stage",
      "dev",
      "test",
    ], var.env)
    error_message = "The env entered is not allowed, please use the correct env"
  }
}

variable "department" {
  description = "departments for access level and expertise"
  type        = string
  default     = "devops"
  validation {
    condition = contains([
      "devops",
      "devsecops",
      "sre",
      "powerdev",
      "dev",
      "intern",
    ], var.department)
    error_message = "The department entered is not allowed, please use the correct department."
  }
}

variable "results" {
  description = "Name of the 'results'"
  type        = string
  default     = ""
}

variable "handler" {
  description = "Function handler to lambda function."
  type        = string
}

variable "runtime" {
  description = "Valid lambda runtime."
  type        = string
}

variable "layers" {
  description = "List of lambda layer arns."
  type        = list(string)
  default     = null
}

variable "layer_name" {
  description = "Name of the lambda layer."
  type        = string
  default     = null
}

variable "layer_runtime" {
  description = "Valid lambda layer runtime."
  type        = string
}

variable "publish" {
  description = "Set to true to publish lambda function as a new version."
  type        = bool
  default     = null
}

variable "s3_bucket" {
  description = "S3 Bucket to push/store lambdas."
  type        = string
  default     = null
}

variable "s3_key_function" {
  description = "S3 key of an object containing the lambda function."
  type        = string
  default     = null
}

variable "s3_key_layer" {
  description = "S3 key of an object containing the lambda layer."
  type        = string
  default     = null
}

variable "s3_lambda_notifications" {
  description = "Map of s3 lambda notifications variables."
  type        = map(any)
}

variable "source_arn" {
  description = "S3 Bucket arn for applying lambda permissions"
  type        = set(string)
}

variable "source_account" {
  description = "Account for Cross Account actions"
  type        = number
}

variable "env_vars" {
  description = "Map of environment variables."
  type        = map(string)
  default     = null
}

variable "memory_size" {
  description = "Size of memory in MB."
  type        = number
  default     = null
}

variable "description" {
  description = "Description of lambda function."
  type        = string
  default     = null
}

variable "timeout" {
  description = "Timeout for lambda function."
  type        = number
  default     = null
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions"
  type        = number
  default     = null
}

variable "subnet_ids" {
  description = "Subnet IDs for VPC configuration. Must specify security group ids if using."
  type        = list(string)
  default     = null
}

variable "security_group_ids" {
  description = "Security Groups configured on the same VPC as the subnets."
  type        = list(string)
  default     = null
}

variable "lambda_function_source_dir" {
  description = "Directory of files to be included in the lambda function zip file."
  type        = string
}

variable "lambda_layer_source_dir" {
  description = "Directory of files to be included in the lambda layer zip file."
  type        = string
}

variable "lambda_function_output_path" {
  description = "Directory containing the lambda function zip files."
  type        = string
}

variable "lambda_layer_output_path" {
  description = "Directory containing the lambda layer zip files."
  type        = string
}

variable "lambda_payload" {
  description = "Lambda Payload File"
  type        = string
}

variable "lambda_alias" {
  description = "Lambda alias name"
  type        = string
}

variable "stage_alias" {
  description = "Lambda version number to point STAGE alias"
  type        = string
}

variable "invoke_policy_arn" {
  description = "IAM Policy to be attached to role"
  type        = list(string)
}

variable "db_access" {
  description = "SSM Parameter Store for DB credentials"
  type        = string
}
