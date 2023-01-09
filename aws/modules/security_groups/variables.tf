variable "app" {
  description = "prefix to be used on all the resources as a tag"
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

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "10.10.0.0/16"
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

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "enable_nat_gateway" {
  description = "enable_nat_gateway true or false"
  default     = false
}

variable "enable_vpc_endpoints" {
  description = "Set to true to enable vpc endpoints."
  default     = false
}

variable "vpc_id" {
  description = "The VPC ID to use"
  type        = string
}

variable "db_port" {
  description = "port for db traffic"
  default     = 5432
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "security_group_description" {
  description = "The description of the security group. If value is set to empty string it will contain cluster name in the description."
  type        = string
  default     = "Managed by Terraform"
}
