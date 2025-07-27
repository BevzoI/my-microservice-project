
resource "helm_release" "jenkins" {
  name       = "jenkins"
  namespace  = "jenkins"
  create_namespace = true

  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  version    = "4.5.2"

  values = [
    templatefile("${path.module}/values.yaml", {
      jenkins_admin_user     = var.jenkins_admin_user
      jenkins_admin_password = var.jenkins_admin_password
    })
  ]
}
