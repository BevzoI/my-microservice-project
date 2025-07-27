
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "jenkins_url" {
  value = module.jenkins.jenkins_url
}

output "argocd_url" {
  value = module.argo_cd.argo_url
}
