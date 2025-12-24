# creating namespace application
resource "kubernetes_namespace" "application" {
  metadata {
    name = "application"
  }

  depends_on = [module.eks, data.aws_eks_cluster.cluster]

  lifecycle {
    ignore_changes = all
  }
}

# creating repo in argocd
resource "kubernetes_secret" "demo-repo" {
  metadata {
    name      = "${var.tag_env}-${var.project_name}-repo"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
    annotations = {
      "kubernetes.io/service-account.name" = "my-service-account"
    }
  }
  data = {
    username = "git"
    password = var.registrationToken
    type: "git"
    url: "https://github.com/${var.cd_project_repo}"
  }
  type = "Opaque"

  depends_on = [helm_release.argocd, module.eks, data.aws_eks_cluster.cluster]

  lifecycle {
    ignore_changes = all
  }
}