resource "aws_db_subnet_group" "ecommerce" {
  name        = "ecommerce-db-subnet-group"
  description = "Subnet group for ecommerce RDS"

  subnet_ids = aws_subnet.database[count.index].id

  tags = {
    Name = "ecommerce-db-subnet-group"
  }
}

resource "aws_db_instance" "ecommerce" {

  identifier = "ecommercedb-instance"

  engine         = "postgres"
  engine_version = "17.4"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "postgres"
  username = "postgres"
  password = data.aws_ssm_parameter.db_password.id

  db_subnet_group_name   = aws_db_subnet_group.ecommerce.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

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