provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source              = "./modules/eks"
  cluster_name        = "bevzo-eks-cluster"
  project_name        = "bevzo"
  subnet_ids          = module.vpc.public_subnets
  node_instance_type  = "t3.medium"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1

  depends_on = [module.vpc]
}

module "rds" {
  source      = "./modules/rds"
  db_name     = "devopsdb"
  db_username = "admin"
  db_password = "admin1234"

  depends_on = [module.vpc]
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = "bevzo"
}

module "jenkins" {
  source = "./modules/jenkins"

  jenkins_admin_user     = "admin"
  jenkins_admin_password = "admin1234"
}

module "argo_cd" {
  source     = "./modules/argo_cd"
  depends_on = [module.eks]
}