resource "aws_db_subnet_group" "ecommerce" {
  name        = "ecommerce-db-subnet-group"
  description = "Subnet group for ecommerce RDS"

  subnet_ids = split(",", data.aws_ssm_parameter.database_subnet_ids.value)

  tags = {
    Name = "ecommerce-db-subnet-group"
  }
}

resource "aws_db_instance" "ecommerce" {

  identifier = "ecommercedb-instance"

  engine         = "postgres"
  engine_version = "17.5"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "postgres"
  username = "postgres"
  password = data.aws_ssm_parameter.db_password.value

  db_subnet_group_name   = aws_db_subnet_group.ecommerce.name
  vpc_security_group_ids = [data.aws_ssm_parameter.rds_sg.value]

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 0

  storage_encrypted = false

  skip_final_snapshot = true
  deletion_protection = false

  performance_insights_enabled = false

  apply_immediately = true

  tags = {
    Name = "ecommercedb-instance"
  }
}