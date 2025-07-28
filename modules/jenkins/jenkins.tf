resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = var.namespace

  create_namespace = true
  version          = "4.10.0"  

  values = [file("${path.module}/values.yaml")]
}
