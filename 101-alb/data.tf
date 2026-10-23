data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/vpc_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/private-subnet_ids"
}

data "aws_ssm_parameter" "product_tg_arn" {
  name = "/${var.project_name}/product_tg_arn"
}

data "aws_ssm_parameter" "cart_tg_arn" {
  name = "/${var.project_name}/cart_tg_arn"
}

data "aws_ssm_parameter" "user_tg_arn" {
  name = "/${var.project_name}/user_tg_arn"
}
data "aws_ssm_parameter" "order_tg_arn" {
  name = "/${var.project_name}/order_tg_arn"
}