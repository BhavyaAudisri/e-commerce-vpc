data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/public-subnet_ids"
}

data "aws_ssm_parameter" "ecommerce_sg_id" {
  name = "/${var.project_name}/ecommerce_sg_id"
}
data "aws_ssm_parameter" "github_token" {
  name = "/ecommerce/github/token"
}

data "aws_ssm_parameter" "user_pool_id" {
  name = "/ecommerce/cognito/user-pool-id"
}

data "aws_ssm_parameter" "app_client_id" {
  name = "/ecommerce/cognito/app-client-id"
}

data "aws_ssm_parameter" "cdn_domain" {
  name = "/ecommerce/cdn_id"
}

data "aws_cloudfront_distribution" "cdn" {
  id = "E31O3QJA5R0U02" # Your existing CloudFront Distribution ID
}