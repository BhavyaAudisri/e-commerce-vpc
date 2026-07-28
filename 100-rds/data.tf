data "aws_ssm_parameter" "db_password" {
    name = "/ecommerce/dev/db/password"
}