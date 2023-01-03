variable "app" {
  description = "prefix to be used on all the resources as a tag indicating the application name"
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

variable "bucket_remote_backend_suffix" {
  description = "the remote backend bucket name suffix"
  type        = string
}

variable "principals" {
  description = "list of user/role ARNs to get full access to the bucket"
  type        = list(string)
}

variable "versioning" {
  description = "enables versioning for objects in the S3 bucket"
  default     = true
}

variable "enable_s3_bucket_policy" {
  description = "creates IAM policy to access remote backend bucket"
  type        = bool
  default     = false
}

variable "enable_s3_bucket_policy_with_mfa" {
  description = "creates IAM policy to access remote backend bucket that requires the user to have MFA enabled"
  type        = bool
  default     = false
}
