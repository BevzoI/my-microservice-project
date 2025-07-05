output "s3_bucket_name" {
  value = module.s3_backend.bucket_name
}

output "dynamodb_table" {
  value = module.s3_backend.table_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}
