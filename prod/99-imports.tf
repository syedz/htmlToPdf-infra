# Import existing SSM parameters
import {
  to = aws_ssm_parameter.save_rds_db_name_to_ssm
  id = "/prod/rds/db_name"
}

import {
  to = aws_ssm_parameter.save_rds_endpoint_to_ssm
  id = "/prod/rds/endpoint"
}

import {
  to = aws_ssm_parameter.save_rds_password_to_ssm
  id = "/prod/rds/password"
}

import {
  to = aws_ssm_parameter.save_rds_admin_username_to_ssm
  id = "/prod/rds/username"
}

import {
  to = aws_ssm_parameter.save_dynamodb_table_name_to_ssm
  id = "/prod/dynamodb/table_name"
}

import {
  to = aws_ssm_parameter.save_name_of_s3_for_output_files_to_ssm
  id = "/prod/s3_bucket/for_output_files/name"
}

import {
  to = aws_ssm_parameter.sqs_arn
  id = "/prod/sqs/arn"
}

import {
  to = aws_ssm_parameter.sqs_name
  id = "/prod/sqs/name"
}

import {
  to = aws_ssm_parameter.sqs_url_path
  id = "/prod/sqs/url"
}

import {
  to = aws_ssm_parameter.save_lambda_iam_role_arn_to_ssm
  id = "/prod/lambda/iam/role/arn"
}

# Import existing IAM role
import {
  to = aws_iam_role.lambda_execution
  id = "prod-lambda-execution-role"
}

# Import existing IAM instance profile
import {
  to = aws_iam_instance_profile.lambda_execution
  id = "prod-lambda-execution-role"
}
