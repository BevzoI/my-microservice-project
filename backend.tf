terraform {
  backend "s3" {
    bucket         = "terraform-iryna-bevzo-state"
    key            = "lesson-5/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-iryna"
    encrypt        = true
  }
}
