variable "service_name" {
  description = "Service whose ECR image will be used"
  type        = string
  default     = "product"

  validation {
    condition = contains(
      ["product", "cart", "user", "order"],
      var.service_name
    )
    error_message = "Valid services are product, cart, user, or order."
  }
}

variable "project_name" {
  default = "ecommerce-vpc"
}

locals {
  service_ports = {
    product = {
      port = 8001
      environment = [
        { name = "ENVIRONMENT", value = "dev" },
        { name = "AWS_REGION", value = "us-east-1" }
      ]
    }
    cart = {
      port = 8002
      environment = [
        { name = "ENVIRONMENT", value = "dev" },
        { name = "AWS_REGION", value = "us-east-1" }
      ]
    }
    user = {
      port = 8003
      environment = [
        { name = "ENVIRONMENT", value = "dev" },
        { name = "AWS_REGION", value = "us-east-1" }
      ]
    }
    order = {
      port = 8004
      environment = [
        { name = "ENVIRONMENT", value = "dev" },
        { name = "AWS_REGION", value = "us-east-1" }
      ]
    }
  }
  service_target_groups = {
    product = aws_lb_target_group.product_tg.arn
    cart    = aws_lb_target_group.cart_tg.arn
    user    = aws_lb_target_group.user_tg.arn
    order   = aws_lb_target_group.order_tg.arn
  }
}