#!/bin/bash

echo "🔧 1. Ініціалізація Terraform..."
terraform init

echo "🚀 2. Застосування інфраструктури Terraform..."
terraform apply -auto-approve

echo "🔄 3. Оновлення kubeconfig..."
aws eks update-kubeconfig --region eu-central-1 --name demo-cluster

echo "✅ 4. Перевірка підключення до Kubernetes..."
kubectl get nodes

echo "📦 5. Встановлення Jenkins через Helm..."
helm upgrade --install jenkins oci://registry-1.docker.io/bitnamicharts/jenkins \
  -n jenkins --create-namespace \
  -f modules/jenkins/values.yaml

echo "🚀 6. Встановлення Argo CD через Helm..."
helm upgrade --install argocd oci://registry-1.docker.io/bitnamicharts/argo-cd \
  -n argocd --create-namespace \
  -f modules/argo_cd/values.yaml

echo "🎉 Готово! Інфраструктура, Jenkins і Argo CD встановлені."
