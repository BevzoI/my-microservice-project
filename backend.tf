terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bevzo-2025"
    key            = "final-project/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "final-devops-locks1"
  }
}