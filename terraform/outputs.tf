output "db_instance_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "cluster_name" {
  value = module.eks.cluster_id
}

output "aws_region" {
  value = var.aws_region
}

output "db_username" {
  value = aws_db_instance.postgres.username
}

output "db_password" {
  value = var.db_password
  sensitive = true
}

output "database_name" {
  value = aws_db_instance.postgres.name
}
