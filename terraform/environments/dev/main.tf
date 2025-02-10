provider "aws" {
  region = var.aws_region
}

locals {
  environment = "dev"
  common_tags = {
    Environment = local.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "s3_buckets" {
  source = "../../modules/s3"

  for_each = {
    raw               = "${var.project_name}-raw-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
    transformed       = "${var.project_name}-transformed-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
    inference_input   = "${var.project_name}-inference-input-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
    inference_output  = "${var.project_name}-inference-output-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
    model            = "${var.project_name}-model-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
    code             = "${var.project_name}-code-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
  }

  bucket_name = each.value
  tags        = local.common_tags
}

module "glue_role" {
  source = "../../modules/iam"
  
  role_name         = "${var.project_name}-glue-role"
  service_principal = "glue.amazonaws.com"
  policy_document   = data.aws_iam_policy_document.glue_policy.json
  tags             = local.common_tags
}

module "sagemaker_role" {
  source = "../../modules/iam"
  
  role_name         = "${var.project_name}-sagemaker-role"
  service_principal = "sagemaker.amazonaws.com"
  policy_document   = data.aws_iam_policy_document.sagemaker_policy.json
  tags             = local.common_tags
}

module "step_functions_role" {
  source = "../../modules/iam"
  
  role_name         = "${var.project_name}-step-functions-role"
  service_principal = "states.amazonaws.com"
  policy_document   = data.aws_iam_policy_document.step_functions_policy.json
  assume_role_policy = data.aws_iam_policy_document.step_functions_assume_role.json  # Añadir esta línea
  tags             = local.common_tags
}

module "glue_job" {
  source = "../../modules/glue"
  
  job_name         = "${var.project_name}-etl-job"
  role_arn         = module.glue_role.role_arn
  code_bucket_name = module.s3_buckets["code"].bucket_name
  tags            = local.common_tags
}

module "sagemaker" {
  source = "../../modules/sagemaker"
  
  code_bucket_name = module.s3_buckets["code"].bucket_name
  tags            = local.common_tags
}


module "step_functions" {
  source = "../../modules/step_functions"
  
  state_machine_name      = "${var.project_name}-pipeline"
  role_arn               = module.step_functions_role.role_arn
  glue_job_name          = module.glue_job.job_name
  sagemaker_role_arn     = module.sagemaker_role.role_arn
  transformed_bucket     = module.s3_buckets["transformed"].bucket_name
  model_bucket          = module.s3_buckets["model"].bucket_name
  inference_input_bucket = module.s3_buckets["inference_input"].bucket_name
  inference_output_bucket = module.s3_buckets["inference_output"].bucket_name
  training_image        = var.sagemaker_training_image
  tags                 = local.common_tags
}