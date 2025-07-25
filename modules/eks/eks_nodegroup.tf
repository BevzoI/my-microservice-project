resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "demo-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  ami_type = "AL2_x86_64"

  remote_access {
    ec2_ssh_key = "eks-key"
  }

  tags = {
    "Name" = "eks-node"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}
