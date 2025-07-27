module "s3-backend" {
  source      = "./modules/s3-backend"
  bucket_name = var.bucket_name
  table_name  = var.table_name
}

module "vpc" {
  source = "./modules/vpc"
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "rds" {
  source      = "./modules/rds"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  depends_on  = [module.vpc]
}


module "jenkins" {
  source = "./modules/jenkins"

  jenkins_admin_user     = var.jenkins_admin_user
  jenkins_admin_password = var.jenkins_admin_password
}

module "argo_cd" {
  source = "./modules/argo_cd"
  depends_on = [module.eks]
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.eks_cluster_name
  subnet_ids         = var.public_subnets
  project_name       = var.project_name
  node_instance_type = var.eks_node_instance_type
  desired_capacity   = var.eks_desired_capacity
  max_size           = var.eks_max_size
  min_size           = var.eks_min_size
}




