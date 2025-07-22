module "vpc" {
  source = "./modules/vpc"
}

module "ecr" {
  source = "./modules/ecr"
}

module "eks" {
  source = "./modules/eks"
}

module "s3-backend" {
  source = "./modules/s3-backend"
}