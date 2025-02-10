output "raw_bucket" {
  value = module.s3_buckets["raw"].bucket_name
}

output "transformed_bucket" {
  value = module.s3_buckets["transformed"].bucket_name
}

output "inference_input_bucket" {
  value = module.s3_buckets["inference_input"].bucket_name
}

output "inference_output_bucket" {
  value = module.s3_buckets["inference_output"].bucket_name
}

output "model_bucket" {
  value = module.s3_buckets["model"].bucket_name
}

output "code_bucket" {
  value = module.s3_buckets["code"].bucket_name
}

output "state_machine_arn" {
  value = module.step_functions.state_machine_arn
}