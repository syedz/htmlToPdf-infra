terraform {
  required_version = ">= 1.4.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.25.2"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.3"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
    time = {
      source = "hashicorp/time"
      version = "0.10.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}

# region in aws
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Team        = "Zee DevOps"
      Project     = "HTML to PDF"
      Environment = "Prod"
      ManagedBy   = "Terraform"
    }
  }
}

# getting eks credentials for helm provider
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    }
  }
}

# getting eks credentials for kubernetes provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_caller_identity" "current" {}
