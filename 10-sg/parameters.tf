resource "aws_ssm_parameter" "ecommerce_sg_id" {
  name  = "/${var.project_name}/ecommerce_sg_id"
  type  = "String"
  value = module.ecommerce_sg.sg_id
 # overwrite = true
}
