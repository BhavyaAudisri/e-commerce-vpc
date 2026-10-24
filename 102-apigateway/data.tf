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

data "aws_ssm_parameter" "internal_alb_dns" {
  name = "/ecommerce/internal_alb_dns"
}

data "aws_ssm_parameter" "default_alb_listener" {
  arn = "arn:aws:elasticloadbalancing:us-east-1:871893060328:listener/app/ecommerce-internal-alb/05b9f310c1f53eea/0c3bc1a62e20beb4"
}