resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/vpc_id"
  type  = "String"
  value = aws_vpc.main.id
  #overwrite = true
}
resource "aws_ssm_parameter" "eip_id" {
  name  = "/${var.project_name}/eip_id"
  type  = "String"
  value = aws_eip.nat.id
 #overwrite = true
}
resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/public-subnet_ids"
  type = "StringList"
  value = join(",", aws_subnet.public[*].id)
  #overwrite = true
}
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/private-subnet_ids"
  type = "StringList"
  value = join(",", aws_subnet.private[*].id)
  #overwrite = true
}
resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project_name}/database-subnet_ids"
  type = "StringList"
  value = join(",", aws_subnet.database[*].id)
  #overwrite = true
 }
