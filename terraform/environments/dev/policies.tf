data "aws_iam_policy_document" "glue_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "${module.s3_buckets["raw"].bucket_arn}/*",
      "${module.s3_buckets["transformed"].bucket_arn}/*",
      module.s3_buckets["raw"].bucket_arn,
      module.s3_buckets["transformed"].bucket_arn
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "glue:*"
    ]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "sagemaker_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "${module.s3_buckets["transformed"].bucket_arn}/*",
      "${module.s3_buckets["model"].bucket_arn}/*",
      "${module.s3_buckets["inference_input"].bucket_arn}/*",
      "${module.s3_buckets["inference_output"].bucket_arn}/*",
      module.s3_buckets["transformed"].bucket_arn,
      module.s3_buckets["model"].bucket_arn,
      module.s3_buckets["inference_input"].bucket_arn,
      module.s3_buckets["inference_output"].bucket_arn
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "sagemaker:*"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "step_functions_policy" {
  statement {
    effect = "Allow"
    actions = [
      "glue:StartJobRun",
      "glue:GetJobRun",
      "glue:GetJobRuns",
      "glue:BatchStopJobRun"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateTrainingJob",
      "sagemaker:DescribeTrainingJob",
      "sagemaker:StopTrainingJob",
      "sagemaker:CreateTransformJob",
      "sagemaker:DescribeTransformJob",
      "sagemaker:StopTransformJob",
      "sagemaker:CreateModel",
      "sagemaker:DeleteModel"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "events:*"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:*"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "states:*"
    ]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "step_functions_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "states.amazonaws.com"
      ]
    }
    actions = ["sts:AssumeRole"]
  }
}
