variable "state_machine_name" {
  description = "Name of the Step Functions state machine"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role for Step Functions"
  type        = string
}

variable "glue_job_name" {
  description = "Name of the Glue job"
  type        = string
}

variable "sagemaker_role_arn" {
  description = "ARN of the SageMaker execution role"
  type        = string
}

variable "transformed_bucket" {
  description = "Name of the transformed data bucket"
  type        = string
}

variable "model_bucket" {
  description = "Name of the model artifacts bucket"
  type        = string
}

variable "inference_input_bucket" {
  description = "Name of the inference input bucket"
  type        = string
}

variable "inference_output_bucket" {
  description = "Name of the inference output bucket"
  type        = string
}

variable "training_image" {
  description = "SageMaker training image URI"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the state machine"
  type        = map(string)
  default     = {}
}