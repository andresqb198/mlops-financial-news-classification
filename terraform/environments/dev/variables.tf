variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "amazon-reviews"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "sagemaker_training_image" {
  description = "SageMaker training image URI"
  type        = string
  default     = "683313688378.dkr.ecr.us-east-2.amazonaws.com/sagemaker-scikit-learn:0.20.0-cpu-py3"
}

