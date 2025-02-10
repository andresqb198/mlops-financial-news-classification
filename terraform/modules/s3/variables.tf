variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the bucket"
  type        = map(string)
  default     = {}
}
