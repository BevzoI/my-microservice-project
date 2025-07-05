terraform {
  backend "s3" {
    bucket         = "your-unique-s3-bucket-name"
    key            = "lesson-5/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
