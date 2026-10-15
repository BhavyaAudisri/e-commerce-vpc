resource "aws_lb_target_group" "product_tg" {
  name        = "product-service-tg"
  
  port        = 8001
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_ssm_parameter.vpc.value

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    port                = 8001
    path                = "/health"
    matcher             = "200-299"
    interval            = 10
  }
}
resource "aws_lb_target_group" "cart_tg" {
  name        = "cart-service-tg"
  port        = 8002
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_ssm_parameter.vpc.value

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    port                = 8002
    path                = "/health"
    matcher             = "200-299"
    interval            = 10
  }
}
resource "aws_lb_target_group" "user_tg" {
  name        = "user-service-tg"
  port        = 8003
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_ssm_parameter.vpc.value

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    port                = 8003
    path                = "/health"
    matcher             = "200-299"
    interval            = 10
  }
}
resource "aws_lb_target_group" "order_tg" {
  name        = "order-service-tg"
  port        = 8004
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_ssm_parameter.vpc.value

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    port                = 8004
    path                = "/health"
    matcher             = "200-299"
    interval            = 10
  }
}
module "alb" {
  source                     = "terraform-aws-modules/alb/aws"
  internal                   = true
  name                       = "ecommerce-internal-alb"
  vpc_id                     = data.aws_ssm_parameter.vpc.value
  subnets                    = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  create_security_group      = false
  security_groups            = [data.aws_ssm_parameter.ecommerce_alb_sg.value]
  enable_deletion_protection = false
}
resource "aws_lb_listener" "default_tg" {
  load_balancer_arn = module.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.product_tg.arn

  }
}
resource "aws_lb_listener_rule" "product_tg" {
  listener_arn = aws_lb_listener.default_tg.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.product_tg.arn
  }

  condition {
    path_pattern {
      values = ["/products/*"]
    }
  }

}
resource "aws_lb_listener_rule" "cart_tg" {
  listener_arn = aws_lb_listener.default_tg.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cart_tg.arn
  }

  condition {
    path_pattern {
      values = ["/cart/*"]
    }
  }

}
resource "aws_lb_listener_rule" "users_tg" {
  listener_arn = aws_lb_listener.default_tg.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.user_tg.arn
  }

  condition {
    path_pattern {
      values = ["/users/*"]
    }
  }

}
resource "aws_lb_listener_rule" "orders_tg" {
  listener_arn = aws_lb_listener.default_tg.arn
  priority     = 30

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.order_tg.arn
  }

  condition {
    path_pattern {
      values = ["/orders/*"]
    }
  }

}