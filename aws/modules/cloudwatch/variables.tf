variable "app" {
  description = "Prefix to be used on all the resources as a tag."
  type        = string
  default     = ""
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
