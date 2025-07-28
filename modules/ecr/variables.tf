variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "final-devops-ecr"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
