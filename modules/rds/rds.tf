
resource "aws_db_instance" "this" {
  count                     = var.use_aurora ? 0 : 1
  identifier                = "${var.name}-rds"
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  allocated_storage         = var.allocated_storage
  username                  = var.username
  password                  = var.password
  db_subnet_group_name      = aws_db_subnet_group.this.name
  vpc_security_group_ids    = [aws_security_group.this.id]
  parameter_group_name      = aws_db_parameter_group.this.name
  publicly_accessible       = var.publicly_accessible
  multi_az                  = var.multi_az
  skip_final_snapshot       = true
  deletion_protection       = false
  storage_encrypted         = true

  tags = {
    Name = "${var.name}-rds"
  }
}
