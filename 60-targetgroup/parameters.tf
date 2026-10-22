
resource "aws_ssm_parameter" "product_tg_arn" {
  name  = "/ecommerce/alb/product_tg_arn"
  type  = "String"
  value = aws_lb_target_group.product_tg.arn
}

resource "aws_ssm_parameter" "cart_tg_arn" {
  name  = "/ecommerce/alb/cart_tg_arn"
  type  = "String"
  value = aws_lb_target_group.cart_tg.arn
}

resource "aws_ssm_parameter" "user_tg_arn" {
  name  = "/ecommerce/alb/user_tg_arn"
  type  = "String"
  value = aws_lb_target_group.user_tg.arn
}

resource "aws_ssm_parameter" "order_tg_arn" {
  name  = "/ecommerce/alb/order_tg_arn"
  type  = "String"
  value = aws_lb_target_group.order_tg.arn
}
