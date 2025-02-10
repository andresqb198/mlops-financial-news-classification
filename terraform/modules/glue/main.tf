resource "aws_glue_job" "this" {
  name         = var.job_name
  role_arn     = var.role_arn
  glue_version = "3.0"
  
  command {
    script_location = "s3://${var.code_bucket_name}/glue_etl.py"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language"               = "python"
    "--continuous-log-logGroup"    = "/aws-glue/jobs/${var.job_name}"
    "--enable-continuous-cloudwatch-log" = "true"
  }

  max_capacity = 2.0
  timeout      = 60

  tags = var.tags
}

resource "aws_s3_object" "glue_script" {
  bucket = var.code_bucket_name
  key    = "glue_etl.py"
  source = "${path.root}/../../../scripts/glue/glue_etl.py"
  etag   = filemd5("${path.root}/../../../scripts/glue/glue_etl.py")
}