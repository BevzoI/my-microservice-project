
output "cluster_id" {
  value = aws_eks_cluster.eks.id
}

output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "node_group_name" {
  value = aws_eks_node_group.node_group.node_group_name
}
