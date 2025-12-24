#####################################
### ECR MODULE
#####################################

module "ecr" {
  name    = "${var.tag_env}-${var.project_name}-ECR"
  source  = "cloudposse/ecr/aws"
  version = "1.0.0"
  image_names = ["${var.project_name}/api", "${var.project_name}/ui", "${var.project_name}/lambda"]
  use_fullname = true
  force_delete = true
  image_tag_mutability = "MUTABLE"
}