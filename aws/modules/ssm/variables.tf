variable "region" {
  description = "AWS region to use"
  type        = string
  default     = "us-west-2"
}

variable "app" {
  description = "Prefix to be used on all the resources as a tag."
}

variable "create_key" {
  description = "Boolean to describe if key should be created or not"
  default     = true
  type        = bool
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

variable "name" {
  description = "Name given resources"
  type        = string
  default     = ""
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = ""
}

variable "db_host" {
  description = "DB Hostname"
  type        = string
  default     = ""
}

variable "password" {
  description = "Master DB password"
  type        = string
  default     = ""
}

variable "aws_iam_user" {
  description = "The IAM user for RDS"
  type        = string
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key if one is set to the cluster."
  type        = string
  default     = ""
}
