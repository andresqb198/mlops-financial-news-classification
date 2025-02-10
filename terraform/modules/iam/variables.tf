variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "service_principal" {
  description = "AWS service principal"
  type        = string
}

variable "policy_document" {
  description = "IAM policy document"
  type        = string
}

variable "assume_role_policy" {
  description = "IAM assume role policy document"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to be applied to the role"
  type        = map(string)
  default     = {}
}