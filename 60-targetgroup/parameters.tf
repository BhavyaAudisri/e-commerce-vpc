
resource "aws_ssm_parameter" "product_tg_arn" {
  name  = "/ecommerce/alb/product_tg_arn"
  type  = "String"
  value = module.alb.dns_name
}

resource "aws_ssm_parameter" "cart_tg_arn" {
  name  = "/ecommerce/alb/cart_tg_arn"
  type  = "String"
  value = module.alb.dns_name
}

resource "aws_ssm_parameter" "user_tg_arn" {
  name  = "/ecommerce/alb/user_tg_arn"
  type  = "String"
  value = module.alb.dns_name
}

resource "aws_ssm_parameter" "order_tg_arn" {
  name  = "/ecommerce/alb/order_tg_arn"
  type  = "String"
  value = module.alb.dns_name
}

resource "aws_ssm_parameter" "internal_alb_dns" {
  name        = "/ecommerce/internal_alb_dns"
  type        = "String"
  value       = module.alb.dns_name
}