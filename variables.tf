variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "s3_bucket_name" {
  description = "S3 bucket name for terraform state"
  type        = string
  default     = "my-terraform-state-bevzo-2025"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for terraform state lock"
  type        = string
  default     = "terraform-locks-bevzo"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "final-devops"
  }
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "dbmaster"
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}
