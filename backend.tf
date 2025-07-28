terraform {
    required_version = ">= 1.3"
  backend "s3" {
    bucket         = "my-terraform-state-bevzo-2025"   
    key            = "lesson8-9/terraform.tfstate"    
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks-bevzo"
    encrypt        = true                 
  }
}
