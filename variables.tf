variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  type        = string
  description = "Project name for ECR repository"
  default     = "my-microservice-project"
}


variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "eks_node_instance_type" {
  description = "Instance type for EKS worker nodes"
  type        = string
}

variable "eks_desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "eks_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "eks_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "jenkins_admin_user" {
  description = "Admin user for Jenkins"
  type        = string
}

variable "jenkins_admin_password" {
  description = "Admin password for Jenkins"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform backend"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table for Terraform lock"
  type        = string
}

