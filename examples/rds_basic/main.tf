module "rds" {
  source               = "../../modules/rds"

  name                 = "test-db"
  use_aurora           = false
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20

  username             = "admin"
  password             = "TestPassword123!"

  vpc_id               = "vpc-xxxxxxxx"
  subnet_ids           = ["subnet-aaaa", "subnet-bbbb"]
  allowed_cidr_blocks  = ["0.0.0.0/0"]

  publicly_accessible  = false
  multi_az             = false

  parameter_group_family = "postgres15"
  max_connections        = "100"
  log_statement          = "mod"
  work_mem               = "4MB"
}