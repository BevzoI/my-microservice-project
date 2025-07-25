
resource "aws_eks_cluster" "this" {
  name     = "demo-cluster"
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}
    