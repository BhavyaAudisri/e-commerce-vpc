data "aws_ssm_parameter" "db_password" {
    name = "/ecommerce/dev/db/password"
}
data "aws_ssm_parameter" "database_subnet_ids" {
    name = "/${var.project_name}/database-subnet_ids"
}