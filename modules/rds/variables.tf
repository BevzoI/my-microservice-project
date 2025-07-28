
variable "name" {
  description = "Base name for all resources"
  type        = string
}

variable "use_aurora" {
  description = "If true, creates Aurora cluster; otherwise creates standard RDS instance"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Database engine (e.g., aurora-postgresql, postgres)"
  type        = string
}

variable "engine_version" {
  description = "Engine version"
  type        = string
}

variable "instance_class" {
  description = "Instance class for RDS or Aurora instances"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size in GB (for RDS instance only)"
  type        = number
  default     = 20
}

variable "username" {
  description = "Master DB username"
  type        = string
}

variable "password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID for security group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for DB subnet group"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access DB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "publicly_accessible" {
  description = "Whether the DB is publicly accessible"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Whether to deploy RDS in Multi-AZ"
  type        = bool
  default     = false
}

variable "parameter_group_family" {
  description = "Parameter group family (e.g., aurora-postgresql15, postgres15)"
  type        = string
}

variable "max_connections" {
  description = "Max allowed connections"
  type        = string
  default     = "100"
}

variable "log_statement" {
  description = "Logging level"
  type        = string
  default     = "none"
}

variable "work_mem" {
  description = "Work memory per query"
  type        = string
  default     = "4096"
}


variable "port" {
  description = "Port number for DB (usually 5432 for PostgreSQL)"
  type        = number
  default     = 5432
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
