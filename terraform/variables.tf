variable "aws_region" {
  description = "AWS Region for the deployment"
  type    = string
  default = null
}

variable "db_username" {
  description = "Username for the RDS database instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database instance"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Database name for the RDS database instance"
  type        = string
}
