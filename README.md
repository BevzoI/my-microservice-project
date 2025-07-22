# Terraform AWS Infrastructure (Ірина Бевзо)

Цей проєкт створює базову інфраструктуру на AWS за допомогою Terraform:

## 📦 Компоненти:

- ✅ **S3 + DynamoDB** для зберігання стейт-файлів Terraform
- ✅ **VPC** з публічними та приватними підмережами
- ✅ **ECR** для зберігання Docker-образів

## 🚀 Команди запуску:

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

## 🔐 Дані:

- S3 bucket: `terraform-iryna-bevzo-state`
- DynamoDB: `terraform-locks-iryna`
- Регіон: `us-east-1`

---

Автор: **Ірина Бевзо**  
Email: `bevzo.i.n@gmail.com`  
GitHub: [BevzoI/my-microservice-project](https://github.com/BevzoI/my-microservice-project)
