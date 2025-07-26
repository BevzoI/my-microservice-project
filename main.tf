
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

resource "aws_iam_role" "eks_node" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attach" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

module "ecr" {
  source   = "./modules/ecr"
  ecr_name = "django-app"
}

module "eks" {
  source           = "./modules/eks"
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = aws_iam_role.eks_cluster.arn
  node_role_arn    = aws_iam_role.eks_node.arn
}

module "s3-backend" {
  source      = "./modules/s3-backend"
  bucket_name = "my-terraform-state-bevzo-2025"
  table_name  = "terraform-locks-bevzo"
}



module "rds" {
  source                = "./modules/rds"

  name                  = "prod-db"
  use_aurora            = true
  engine                = "aurora-postgresql"
  engine_version        = "15.3"
  instance_class        = "db.t3.medium"
  allocated_storage     = 20

  username              = "dbmaster"
  password              = "SuperSecurePass123!"

  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  allowed_cidr_blocks   = ["10.0.0.0/16"]

  publicly_accessible   = false
  multi_az              = false

  parameter_group_family = "aurora-postgresql15"
  max_connections        = "150"
  log_statement          = "mod"
  work_mem               = "8MB"
  port                   = 5432
}
