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

variable "tags" {
  default     = {}
  description = "A mapping of tags to assign to the object"
  type        = "map"
}

variable "vpc_config" {
  default     = {}
  description = "Provide this to allow your function to access your VPC."
  type        = "map"
}
