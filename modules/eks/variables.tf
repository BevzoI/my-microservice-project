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

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for EKS cluster and node group"
}

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for node group"
  default     = ["t3.medium"]
}

variable "node_desired_capacity" {
  type    = number
  default = 2
}

variable "node_min_capacity" {
  type    = number
  default = 1
}

variable "node_max_capacity" {
  type    = number
  default = 3
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
