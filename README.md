# Домашнє завдання: Argo CD + CI/CD

Цей проєкт реалізує повний DevOps-конвеєр для Django-застосунку з використанням:

- Jenkins (CI)
- Amazon ECR (Docker Registry)
- Helm (Deployment)
- Argo CD (GitOps)
- Terraform (інфраструктура як код)

---

##  Структура CI/CD

### CI (Jenkins)

1. **Jenkinsfile** автоматично:
   - Клонує репозиторій
   - Будує Docker-образ за допомогою Kaniko
   - Публікує його в Amazon ECR
   - Оновлює `charts/django-app/values.yaml` з новим тегом
   - Пушить зміни в гілку `lesson-8-9`

> Використовується Jenkins Kubernetes Agent з образом `kaniko`.

---

### CD (Argo CD)

1. **Argo CD** розгортається через Helm (`modules/argo_cd`)
2. Використовується Helm-чарт `argo-apps`, який створює ArgoCD Application:
   - Repo: https://github.com/BevzoI/my-microservice-project.git
   - Path: `charts/django-app`
   - Гілка: `lesson-8-9`
3. Після зміни у `values.yaml`, ArgoCD автоматично синхронізує деплоймент у кластері

---

## Як розгорнути

### 1. Ініціалізувати Terraform
```bash
cd your-project/
terraform init
terraform apply
```

### 2. Створити секрет з AWS-ключами для Jenkins
```bash
kubectl create secret generic aws-ecr-creds \
  --from-literal=aws_access_key_id=<YOUR_KEY> \
  --from-literal=aws_secret_access_key=<YOUR_SECRET> \
  -n jenkins
```

### 3. Додати GitHub Token до Jenkins Credentials
- ID: `github-token`
- Type: Secret Text
- Value: `<your_github_pat>`

### 4. Запустити Jenkins pipeline
- Він автоматично:
  - Збере образ
  - Пушить у ECR
  - Оновить Helm chart
  - Git push
  - ArgoCD виконає автодеплой

---

## 📁 Шлях до Helm chart
- `charts/django-app/` — основний Helm chart
- `modules/argo_cd/charts/argo-apps/` — Argo CD Application chart

---

## ✅ Готово!

Система повністю автоматизована: від push-а коду — до оновлення застосунку у Kubernetes через Argo CD.
