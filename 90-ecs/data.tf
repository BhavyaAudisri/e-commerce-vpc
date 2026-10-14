data "aws_ssm_parameter" "ecr_image" {
  name = "/ecommerce/${var.service_name}/image"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/private-subnet_ids"
}

data "aws_ssm_parameter" "ecommerce_ecs_sg" {
  name = "/${var.project_name}/ecommerce_ecs_id"
}