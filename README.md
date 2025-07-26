
# Terraform RDS Module

Універсальний Terraform-модуль для створення бази даних у AWS. Підтримує як звичайну RDS instance, так і Aurora кластер.

## Можливості

- Підтримка перемикача use_aurora = true/false
- Автоматичне створення:
  - DB Subnet Group
  - Security Group
  - Parameter Group
- Повністю конфігурується через змінні

## Приклад використання

module "rds" {
  source                = "./modules/rds"

  name                  = "prod-db"
  use_aurora            = true
  engine                = "aurora-postgresql"
  engine_version        = "15.3"
  instance_class        = "db.t3.medium"
  allocated_storage     = 20

  username              = "dbmaster"
  password              = "SuperSecurePass123!"

  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  allowed_cidr_blocks   = ["10.0.0.0/16"]

  publicly_accessible   = false
  multi_az              = false

  parameter_group_family = "aurora-postgresql15"
  max_connections        = "150"
  log_statement          = "mod"
  work_mem               = "8MB"
  port                   = 5432
}

## Змінні

- `use_aurora` — true або false, вибір між Aurora та звичайною RDS
- `engine`, `engine_version`, `instance_class` — характеристики бази
- `username`, `password` — креденшели адміністратора
- `vpc_id`, `subnet_ids`, `allowed_cidr_blocks` — мережеві налаштування
- `parameter_group_family`, `log_statement`, `work_mem`, `max_connections`, `port` — параметри конфігурації

## Outputs

- `db_endpoint`
- `db_port`
- `db_subnet_group`
- `db_security_group_id`
- `db_parameter_group`

## Інструкція

1. Ініціалізуйте Terraform:
   terraform init

2. Перевірте:
   terraform plan

3. Застосуйте:
   terraform apply
