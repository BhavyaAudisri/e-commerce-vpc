data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/private-subnet_ids"
}

data "aws_ssm_parameter" "vpclink_sg" {
  name = "/${var.project_name}/vpclink_sg"
}
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/vpc_id"
}

data "aws_ssm_parameter" "cognito_user_pool_id" {
  name = "/ecommerce/cognito/user-pool-id"
}