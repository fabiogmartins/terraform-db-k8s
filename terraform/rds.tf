resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-dbsubnet-group"
  subnet_ids = module.vpc.public_subnets


  tags = {
    Name = "MyDBSubnetGroup"
  }
}

resource "aws_db_instance" "postgres" {
  engine                  = "postgres"
  engine_version          = "13.8"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  max_allocated_storage   = 100
  storage_type            = "gp2"
  identifier              = "my-postgres-db"
  username                = var.db_username
  password                = var.db_password
  name                    = var.database_name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7
  publicly_accessible    = true
  db_subnet_group_name    = aws_db_subnet_group.my_db_subnet_group.name

  tags = {
    "Name" = "my-postgres-db"
  }
  depends_on = [aws_db_subnet_group.my_db_subnet_group]
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow internal access to the RDS Postgres instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}
