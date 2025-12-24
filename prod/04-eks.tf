#####################################
### EKS MODULE
#####################################

module "eks" {
  source                  = "terraform-aws-modules/eks/aws"
  name                    = "${var.tag_env}-${var.project_name}-EKS"
  version                 = "21.10.1"
  kubernetes_version      = "1.34"
  endpoint_private_access = true
  endpoint_public_access  = true
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnets

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
      before_compute = true # CRITICAL: Ensures networking is ready before nodes launch
    }
  }

  node_security_group_additional_rules = {
    ingress_source_security_group_id = {
      description              = "Ingress from another computed security group"
      protocol                 = "tcp"
      from_port                = 80
      to_port                  = 80
      type                     = "ingress"
      source_security_group_id = module.eks.node_security_group_id
    }
  }

  eks_managed_node_groups = {
    internal-service = {
      min_size                     = 2
      max_size                     = 2
      desired_size                 = 2
      disk_size                    = 50
      instance_types               = ["t3.large"]
      capacity_type                = "SPOT"
      subnet_ids                   = module.vpc.private_subnets
      # In this example, for simplicity, common Admin rights are used. However, we recommend ensuring more granular permissions.
      iam_role_additional_policies = { AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess" }
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.cluster_name
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks.cluster_name
  ]
}

data "aws_availability_zones" "available" {}