
variable "cluster_role_arn" {}
variable "subnet_ids" {
  type = list(string)
}
  
variable "node_role_arn" {
  description = "ARN ролі, яку використовує Node Group"
  type        = string
}
