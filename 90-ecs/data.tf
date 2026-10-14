data "aws_ssm_parameter" "ecr_image" {
  name = "/ecommerce/${var.service_name}/image"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/private-subnet_ids"
}