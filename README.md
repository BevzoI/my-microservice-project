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
---

## 🔄 CI/CD Pipeline Overview

Цей проєкт реалізує повний CI/CD-процес за допомогою **Jenkins + Terraform + Helm + Argo CD**:

### 🧱 Інфраструктура
- **Terraform** створює:
  - S3 + DynamoDB для бекенду
  - VPC + EKS кластер
  - Jenkins (через Helm)
  - Argo CD (через Helm)
  - ECR репозиторій

### ⚙️ Jenkins Pipeline
Реалізовано у `Jenkinsfile`:
1. **Збір Docker-образу**
2. **Публікація в Amazon ECR**
3. **Оновлення `values.yaml` Helm-чарта з новим тегом**
4. **Push у GitHub — Argo CD підхоплює зміни**

### 🚀 Argo CD
- Argo CD автоматично синхронізує застосунок із кластером, коли змінюється Helm chart у Git.
- Використовує Helm-чарт `charts/django-app/`.

---

## 📦 Команди

### Terraform
```bash
terraform init
terraform apply
```

### Jenkins
- Доступ після деплою: `http://<jenkins-url>`
- Логін/пароль: `admin` / `admin` (див. `values.yaml`)

### Argo CD
- Доступ після деплою: `http://<argocd-url>`
- Логін: `admin`, пароль з `kubectl -n argocd get secret argocd-initial-admin-secret`

---
