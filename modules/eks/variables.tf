
variable "cluster_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "project_name" {
  type = string
}

variable "node_instance_type" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}
