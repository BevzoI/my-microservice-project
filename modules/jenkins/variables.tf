variable "namespace" {
  description = "Namespace to deploy Jenkins"
  type        = string
  default     = "jenkins"
}

variable "chart_version" {
  description = "Version of Jenkins Helm chart"
  type        = string
  default     = "4.8.9"
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}
