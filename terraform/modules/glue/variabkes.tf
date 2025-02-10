variable "job_name" {
  description = "Name of the Glue job"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role for Glue"
  type        = string
}

variable "code_bucket_name" {
  description = "Name of the S3 bucket containing code"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the Glue job"
  type        = map(string)
  default     = {}
}
