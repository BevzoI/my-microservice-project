#!/bin/bash
set -e

echo "🔧 Initializing Terraform..."
terraform init

echo "🚀 Applying Terraform (auto-approve)..."
terraform apply -auto-approve

echo "✅ Done."
