resource "aws_lb_target_group" "product_tg" {
  name     = product_service_tg
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    protocol = "HTTP"
    port = 8001
    path = "/health"
    matcher = "200-299"
    interval = 10
  }
}