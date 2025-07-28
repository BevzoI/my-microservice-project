output "argocd_namespace" {
  value = var.namespace
}

output "argocd_server_service" {
  value = "LoadBalancer service installed in namespace ${var.namespace}"
}
