
output "jenkins_admin_password" {
  value       = "03102020"
  description = "Initial Jenkins admin password"
  sensitive   = true
}

output "jenkins_namespace" {
  value = var.namespace
}
