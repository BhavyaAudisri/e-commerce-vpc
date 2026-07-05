module "rds_sg" {
    source = "git::https://github.com/BhavyaAudisri/terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "rds_sg"
    sg_description = "Created for rds instances in ecommerce dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

resource "aws_security_group_rule" "rds_sg" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks = ["10.10.0.0/16"]
  security_group_id = module.rds_sg.sg_id
}

module "ecommerce_alb_sg" {
    source = "git::https://github.com/BhavyaAudisri/terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "ecommerce_alb_sg"
    sg_description = "Created for alb in ecommerce dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

resource "aws_security_group_rule" "alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["10.10.0.0/16"]
  security_group_id = module.ecommerce_alb_sg.sg_id
}

resource "aws_security_group_rule" "alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["10.10.0.0/16"]
  security_group_id = module.ecommerce_alb_sg.sg_id
}

module "ecommerce_ecs_sg" {
    source = "git::https://github.com/BhavyaAudisri/terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "ecommerce_ecs_sg"
    sg_description = "Created for  ecommerce-ecs-sg in ecommerce dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}

resource "aws_security_group_rule" "product_sg" {
  type              = "ingress"
  from_port         = 8001
  to_port           = 8001
  protocol          = "tcp"
  source_security_group_id = module.ecommerce_alb_sg.sg_id
  security_group_id = module.ecommerce_ecs_sg.sg_id
}
resource "aws_security_group_rule" "cart_sg" {
  type              = "ingress"
  from_port         = 8002
  to_port           = 8002
  protocol          = "tcp"
  source_security_group_id = module.ecommerce_alb_sg.sg_id
  security_group_id = module.ecommerce_ecs_sg.sg_id
}
resource "aws_security_group_rule" "users_sg" {
  type              = "ingress"
  from_port         = 8003
  to_port           = 8003
  protocol          = "tcp"
  source_security_group_id = module.ecommerce_alb_sg.sg_id
  security_group_id = module.ecommerce_ecs_sg.sg_id
}
resource "aws_security_group_rule" "orders_sg" {
  type              = "ingress"
  from_port         = 8004
  to_port           = 8004
  protocol          = "tcp"
  source_security_group_id = module.ecommerce_alb_sg.sg_id
  security_group_id = module.ecommerce_ecs_sg.sg_id
}

module "vpclink_sg" {
    source = "git::https://github.com/BhavyaAudisri/terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "vpclink_sg"
    sg_description = "Created for  vpclink_sg in ecommerce dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}
resource "aws_security_group_rule" "vpclink_sg_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpclink_sg.sg_id
}
resource "aws_security_group_rule" "vpclink_sg_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpclink_sg.sg_id
}

module "ecommerce_sg" {
    source = "git::https://github.com/BhavyaAudisri/terraform-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "ecommerce_sg"
    sg_description = "Created for rds instances in ecommerce dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
}
resource "aws_security_group_rule" "ecommerce" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ecommerce_sg.sg_id
}

resource "aws_security_group_rule" "ecommerce_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ecommerce_sg.sg_id
}