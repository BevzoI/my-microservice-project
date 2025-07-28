resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.namespace

  create_namespace = true
  version          = "4.17.0"  

  values = [file("${path.module}/values.yaml")]
}
