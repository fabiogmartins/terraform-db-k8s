variable "aws_region" {
  description = "AWS Region for the deployment"
}

variable "db_username" {
  description = "Username for the RDS database instance"
}

variable "db_password" {
  description = "Password for the RDS database instance"
  sensitive   = true
}

variable "database_name" {
  description = "Database name for the RDS database instance"
}
