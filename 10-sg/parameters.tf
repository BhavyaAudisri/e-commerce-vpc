resource "aws_ssm_parameter" "ecommerce_sg_id" {
  name  = "/${var.project_name}/ecommerce_sg_id"
  type  = "String"
  value = module.ecommerce_sg.sg_id
 # overwrite = true
}
resource "aws_ssm_parameter" "rds_sg" {
  name  = "/${var.project_name}/rds_sg_id"
  type  = "String"
  value = module.rds_sg.sg_id
 # overwrite = true
}
resource "aws_ssm_parameter" "ecommerce_alb_sg" {
  name  = "/${var.project_name}/ecommerce_alb_sg"
  type  = "String"
  value = module.ecommerce_alb_sg.sg_id
 # overwrite = true
}
resource "aws_ssm_parameter" "ecommerce_ecs_sg" {
  name  = "/${var.project_name}/ecommerce_ecs_sg"
  type  = "String"
  value = module.ecommerce_ecs_sg.sg_id
 # overwrite = true
}
resource "aws_ssm_parameter" "vpclink_sg" {
  name  = "/${var.project_name}/vpclink_sg"
  type  = "String"
  value = module.vpclink_sg.sg_id
 # overwrite = true
}