provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = var.namespace

  create_namespace = true
  version          = var.chart_version

  values = [file("${path.module}/values.yaml")]

  depends_on = [module.eks]
}
