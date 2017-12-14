variable "filename" {
  description = "The path to the function's deployment package within the local filesystem"
  type        = "string"
}

variable "function_name" {
  description = "The name of the lambda function to create"
  type        = "string"
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = "string"
}

variable "runtime" {
  description = "The runtime environment for the Lambda function you are uploading."
  type        = "string"
}

variable "security_group_ids" {
  description = "A list of security group IDs associated with the Lambda function"
  type        = "list"
}

variable "subnet_ids" {
  description = "A list of subnet IDs associated with the Lambda function"
  type        = "list"
}

variable "tags" {
  default     = {}
  description = "A mapping of tags to assign to the object"
  type        = "map"
}
