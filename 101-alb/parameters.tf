resource "aws_ssm_parameter" "product_service"{
name  = "/ecommerce/dev/product-service-url"
  type  = "String"
  value = "http://${module.ecommerce-internal-alb.dns_name}/product"

}
resource "aws_ssm_parameter" "cart_service"{
name  = "/ecommerce/dev/cart-service-url"
  type  = "String"
  value = "http://${module.ecommerce-internal-alb.dns_name}/cart"

}
resource "aws_ssm_parameter" "user_service"{
name  = "/ecommerce/dev/product-user-url"
  type  = "String"
  value = "http://${module.ecommerce-internal-alb.dns_name}/user"

}
resource "aws_ssm_parameter" "order_service"{
name  = "/ecommerce/dev/order-service-url"
  type  = "String"
  value = "http://${module.ecommerce-internal-alb.dns_name}/order"

}