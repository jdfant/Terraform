variable "name" {
  description = "prefix to be used on all the resources as a tag indicating the bucket name"
  type        = string
}

variable "bucket_remote_backend_suffix" {
  description = "the remote backend bucket name suffix"
  type        = string
}

variable "enable_s3_bucket_policy" {
  description = "creates IAM policy to access remote backend bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}