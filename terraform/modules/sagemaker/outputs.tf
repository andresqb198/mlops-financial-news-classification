output "train_script_key" {
  value = aws_s3_object.train_script.key
}

output "inference_script_key" {
  value = aws_s3_object.inference_script.key
}