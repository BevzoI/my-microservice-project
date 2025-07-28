
output "db_endpoint" {
  description = "Database endpoint"
  value = var.use_aurora ? aws_rds_cluster.this[0].endpoint : aws_db_instance.this[0].endpoint
}

output "db_port" {
  description = "Database port"
  value = var.use_aurora ? aws_rds_cluster.this[0].port : aws_db_instance.this[0].port
}

output "db_subnet_group" {
  description = "Subnet group name"
  value       = aws_db_subnet_group.this.name
}

output "db_security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.this.id
}

output "db_parameter_group" {
  description = "Parameter group name"
  value       = aws_db_parameter_group.this.name
}
