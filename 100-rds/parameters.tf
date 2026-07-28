resource "aws_ssm_parameter" "db_host" {
    name = "/ecommerce/dev/db/host"
    type  = "String"
    value = "aws_db_instance.ecommerce.id"
    overwrite = true
}