variable "name" {
  description = "DynamoDB Table Name"
  type        = string
}

variable "tags" {
  description = "A map of Tags to add for all resources"
  type        = map(string)
}