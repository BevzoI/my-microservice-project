module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = "my-vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  availability_zones = ["eu-central-1a", "eu-central-1b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy_attach" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


module "ecr" {
  source   = "./modules/ecr"
  ecr_name = "django-app"
}

module "eks" {
  source           = "./modules/eks"
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = aws_iam_role.eks_cluster.arn
    node_role_arn = module.vpc.node_role_arn
}


module "s3-backend" {
  source      = "./modules/s3-backend"
  bucket_name = "my-terraform-state-bevzo-2025"
  table_name  = "terraform-locks-bevzo"
}
