resource "aws_sfn_state_machine" "this" {
  name     = var.state_machine_name
  role_arn = var.role_arn

  definition = templatefile("${path.root}/../../../step_functions/state_machine_definition.json", {
    glue_job_name           = var.glue_job_name
    sagemaker_role_arn      = var.sagemaker_role_arn
    transformed_bucket      = var.transformed_bucket
    model_bucket           = var.model_bucket
    inference_input_bucket  = var.inference_input_bucket
    inference_output_bucket = var.inference_output_bucket
    training_image         = var.training_image
  })

  tags = var.tags
}