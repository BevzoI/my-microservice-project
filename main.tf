terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.5"  
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7"
    }
  }
}


provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "s3_backend" {
  source              = "./modules/s3-backend"
  bucket_name         = var.s3_bucket_name
  dynamodb_table_name = var.dynamodb_table_name
  tags                = var.common_tags
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.101.0/24", "10.0.102.0/24"]
  azs                = ["eu-central-1a", "eu-central-1b"]
  enable_nat_gateway = true
  tags               = var.common_tags
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy_attach" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role" "eks_node" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attach" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attach" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "final-devops-ecr"
  tags            = var.common_tags
}

module "eks" {
  source           = "./modules/eks"
  cluster_name     = "final-devops-eks"
  cluster_role_arn = aws_iam_role.eks_cluster.arn
  node_role_arn    = aws_iam_role.eks_node.arn
  subnet_ids       = module.vpc.private_subnets
  instance_types   = ["t3.medium"]
  node_desired_capacity = 2
  node_min_capacity     = 1
  node_max_capacity     = 3
  common_tags           = var.common_tags
}

module "rds" {
  source                = "./modules/rds"
  name                  = "prod-db"
  use_aurora            = true
  engine                = "aurora-postgresql"
  engine_version        = "15.3"
  instance_class        = "db.t3.medium"
  allocated_storage     = 20
  username              = var.db_username
  password              = var.db_password
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnets
  allowed_cidr_blocks   = ["10.0.0.0/16"]
  publicly_accessible   = false
  multi_az              = false
  parameter_group_family = "aurora-postgresql15"
  max_connections        = "150"
  log_statement          = "mod"
  work_mem               = "8MB"
  port                   = 5432
  tags                   = var.common_tags
}

module "jenkins" {
  source        = "./modules/jenkins"
  namespace     = "jenkins"
  chart_version = "4.8.9"
}

module "argo_cd" {
  source        = "./modules/argo_cd"
  namespace     = "argocd"
  chart_version = "4.12.4"
}
