data "aws_ssm_parameter" "vpc" {

  name = "/${var.project_name}/vpc_id"

}