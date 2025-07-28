variable "namespace" {
  description = "Namespace to deploy Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Version of Argo CD Helm chart"
  type        = string
  default     = "4.12.4"
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}
