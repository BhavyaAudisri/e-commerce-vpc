data "aws_ssm_parameter" "ecr_image" {
  name = "/ecommerce/${var.service_name}/image"
}