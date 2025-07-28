variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM Role ARN for EKS cluster"
}

variable "node_role_arn" {
  type        = string
  description = "IAM Role ARN for EKS node group"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for node group"
  default     = ["t3.medium"]
}

variable "node_desired_capacity" {
  type        = number
  default     = 2
}

variable "node_min_capacity" {
  type        = number
  default     = 1
}

variable "node_max_capacity" {
  type        = number
  default     = 3
}

