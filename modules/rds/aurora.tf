
resource "aws_rds_cluster" "this" {
  count                     = var.use_aurora ? 1 : 0
  cluster_identifier        = "${var.name}-aurora-cluster"
  engine                    = var.engine
  engine_version            = var.engine_version
  master_username           = var.username
  master_password           = var.password
  db_subnet_group_name      = aws_db_subnet_group.this.name
  vpc_security_group_ids    = [aws_security_group.this.id]
  skip_final_snapshot       = true
  deletion_protection       = false
  storage_encrypted         = true

  tags = {
    Name = "${var.name}-aurora-cluster"
  }
}

resource "aws_rds_cluster_instance" "writer" {
  count              = var.use_aurora ? 1 : 0
  identifier         = "${var.name}-aurora-writer"
  cluster_identifier = aws_rds_cluster.this[0].id
  instance_class     = var.instance_class
  engine             = var.engine
  engine_version     = var.engine_version
  publicly_accessible = var.publicly_accessible

  tags = {
    Name = "${var.name}-aurora-writer"
  }
}
