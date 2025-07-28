resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  version         = "1.32"
  node_group_name = "demo-node-group-3"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.micro"]
  ami_type       = "BOTTLEROCKET_x86_64"

  remote_access {
    ec2_ssh_key = "eks-key"
  }

  tags = merge(var.common_tags, {
    "Name" = "eks-node"
  })

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}
