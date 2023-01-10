variable "region" {
  description = "AWS region"
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

variable "sns_topic" {
  description = "SNS topic name"
  type        = string
}

variable "sns_account" {
  description = "Account ID of the SNS Topic"
  type        = number
}

variable "http_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = number
  default     = 100
}

variable "sns_endpoint" {
  description = "Name of the SNS Endpoint"
  type        = string
}

variable "function_name" {
  description = "Name of the lambda function"
  type        = string
  default = ""
}
