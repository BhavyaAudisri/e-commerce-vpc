data "aws_ssm_parameter" "ecr_image" {
  name = "/ecommerce/${var.service_name}/image"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/private-subnet_ids"
}

data "aws_ssm_parameter" "ecommerce_ecs_sg" {
  name = "/${var.project_name}/ecommerce_ecs_sg"
}


data "aws_ssm_parameter" "product_tg_arn" {
  name = "/ecommerce/alb/product_tg_arn"
}

data "aws_ssm_parameter" "cart_tg_arn" {
  name = "/ecommerce/alb/cart_tg_arn"
}

data "aws_ssm_parameter" "user_tg_arn" {
  name = "/ecommerce/alb/user_tg_arn"
}

data "aws_ssm_parameter" "order_tg_arn" {
  name = "/ecommerce/alb/order_tg_arn"
}
