module "alb" {
  source   = "terraform-aws-modules/alb/aws"
  internal = true
  /* product_target_group_arn = data.aws_ssm_parameter.product_tg_arn.value
  cart_target_group_arn    = data.aws_ssm_parameter.cart_tg_arn.value
  user_target_group_arn    = data.aws_ssm_parameter.user_tg_arn.value
  order_target_group_arn   = data.aws_ssm_parameter.order_tg_arn.value  */
  name                       = "ecommerce-internal-alb"
  vpc_id                     = data.aws_ssm_parameter.vpc_id.value
  subnets                    = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  create_security_group      = false
  security_groups            = [local.app_alb_sg_id]
  enable_deletion_protection = false
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.product.arn

  }
}

resource "aws_lb_listener_rule" "product" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = data.aws_ssm_parameter.product_tg_arn.value
  }

  condition {
    path_pattern {
      values = ["/products/*"]
    }
  }
}
resource "aws_lb_listener_rule" "cart" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = data.aws_ssm_parameter.cart_tg_arn.value
  }

  condition {
    path_pattern {
      values = ["/cart/*"]
    }
  }
}

resource "aws_lb_listener_rule" "user" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 30

  action {
    type             = "forward"
    target_group_arn = data.aws_ssm_parameter.user_tg_arn.value
  }

  condition {
    path_pattern {
      values = ["/users/*"]
    }
  }
}

resource "aws_lb_listener_rule" "order" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 40

  action {
    type             = "forward"
    target_group_arn = data.aws_ssm_parameter.order_tg_arn.value
  }

  condition {
    path_pattern {
      values = ["/orders/*"]
    }
  }
}