#####################################
### SQS MODULE
#####################################

module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "5.1.0"

  content_based_deduplication = true
  fifo_queue                  = true
  visibility_timeout_seconds  = 360
  name                        = "${var.tag_env}-${var.project_name}-conversion-to-pdf"
  use_name_prefix             = true      # Determines whether "name" is used as a prefix

  create = true
}

# saving created sqs arn into ssm
resource "aws_ssm_parameter" "sqs_arn" {
  name        = "/${var.tag_env}-${var.project_name}/sqs/arn"
  description = "The ARN the created Amazon SQS queue"
  type        = "SecureString"
  value       = module.sqs.queue_arn
}

# saving created sqs name into ssm
resource "aws_ssm_parameter" "sqs_name" {
  name        = "/${var.tag_env}-${var.project_name}/sqs/name"
  description = "Name of the created Amazon SQS queue"
  type        = "SecureString"
  value       = module.sqs.queue_name
}

# saving created sqs url into ssm
resource "aws_ssm_parameter" "sqs_url_path" {
  name        = "/${var.tag_env}-${var.project_name}/sqs/url"
  description = "The URL for the created Amazon SQS queue"
  type        = "SecureString"
  value       = module.sqs.queue_id
}
