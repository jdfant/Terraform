variable "app" {
  description = "prefix to be used on all the resources as a tag"
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

variable "vpc_cidr" {
  description = "vpc cidr, will be added to sg for intra vpc communication"
  type        = list(string)
}

variable "office_cidr" {
  description = "cidr address to be added to SG, ssh as well http access will be granted"
  type        = list(string)
}

variable "security_group_allowed_cidrs" {
  description = "cidr address to be added to SG - for CROS - do not put office ip here"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID to use"
  type        = string
}

variable "db_port" {
  description = "port for db traffic"
  type        = number
  default     = 5432
}

variable "security_group_description" {
  description = "The description of the security group. If value is set to empty string it will contain cluster name in the description."
  type        = string
  default     = "Managed by Terraform"
}
