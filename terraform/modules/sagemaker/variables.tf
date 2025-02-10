variable "code_bucket_name" {
  description = "Name of the S3 bucket containing code"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to SageMaker resources"
  type        = map(string)
  default     = {}
}