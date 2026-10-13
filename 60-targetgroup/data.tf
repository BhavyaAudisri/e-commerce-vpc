data "aws_ssm_parameter" "vpc" {

  name = "/${var.project_name}/vpc_id"

}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/private-subnet_ids"
}

data "aws_ssm_parameter" "ecommerce_alb_sg_id" {
  name = "/ecommerce/alb/ecommerce_alb_sg"
}