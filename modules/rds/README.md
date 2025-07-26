
# Terraform RDS Module

Універсальний Terraform-модуль для створення RDS або Aurora бази даних.

## Можливості

- `use_aurora = true` → створюється Aurora Cluster;
- `use_aurora = false` → створюється стандартна RDS instance;
- Автоматичне створення:
  - DB Subnet Group
  - Security Group
  - Parameter Group

## Приклад використання

```hcl
module "rds" {
  source                = "../modules/rds"

  name                  = "mydb"
  use_aurora            = true
  engine                = "aurora-postgresql"
  engine_version        = "15.3"
  instance_class        = "db.t3.medium"
  allocated_storage     = 20

  username              = "admin"
  password              = "supersecurepassword"

  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnets
  allowed_cidr_blocks   = ["10.0.0.0/16"]

  publicly_accessible   = false
  multi_az              = false

  parameter_group_family = "aurora-postgresql15"
  max_connections        = "200"
  log_statement          = "mod"
  work_mem               = "8MB"
}
```

## Змінні

| Назва                   | Тип           | Опис                                             | За замовчуванням  |
|-------------------------|----------------|--------------------------------------------------|--------------------|
| `use_aurora`            | `bool`         | Вибір між Aurora або звичайною RDS               | `false`            |
| `engine`                | `string`       | Тип БД (`aurora-postgresql`, `postgres`)         | -                  |
| `engine_version`        | `string`       | Версія БД                                        | -                  |
| `instance_class`        | `string`       | Тип інстансу                                     | -                  |
| `allocated_storage`     | `number`       | Розмір зберігання (лише для RDS)                 | `20`               |
| `username`              | `string`       | Імʼя адміністратора                              | -                  |
| `password`              | `string`       | Пароль адміністратора                            | -                  |
| `vpc_id`                | `string`       | ID VPC                                           | -                  |
| `subnet_ids`            | `list(string)` | Список приватних підмереж                        | -                  |
| `allowed_cidr_blocks`   | `list(string)` | Дозволені CIDR-блоки                             | `["0.0.0.0/0"]`    |
| `publicly_accessible`   | `bool`         | Публічний доступ до БД                           | `false`            |
| `multi_az`              | `bool`         | Multi-AZ (тільки RDS)                            | `false`            |
| `parameter_group_family`| `string`       | Тип параметр-групи                               | -                  |
| `max_connections`       | `string`       | Макс. підключень                                 | `"100"`            |
| `log_statement`         | `string`       | Рівень логування                                 | `"none"`           |
| `work_mem`              | `string`       | Памʼять на запит                                 | `"4MB"`            |

## Outputs

- `db_endpoint`
- `db_port`
- `db_subnet_group`
- `db_security_group_id`
- `db_parameter_group`
