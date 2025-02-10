resource "aws_s3_object" "train_script" {
  bucket = var.code_bucket_name
  key    = "train.py"
  source = "${path.root}/../../../scripts/sagemaker/train.py"
  etag   = filemd5("${path.root}/../../../scripts/sagemaker/train.py")
}

resource "aws_s3_object" "inference_script" {
  bucket = var.code_bucket_name
  key    = "inference.py"
  source = "${path.root}/../../../scripts/sagemaker/inference.py"
  etag   = filemd5("${path.root}/../../../scripts/sagemaker/inference.py")
}