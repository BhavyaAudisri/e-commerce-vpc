resource "aws_ecs_task_definition" "service" {
  foreach = local.service_ports
  family                   = "ecommerce-${each.key}-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "${var.service_name}-service"
      image     = data.aws_ssm_parameter.ecr_image.value
      essential = true

      portMappings = [
        {
          containerPort = local.service_ports[var.service_name].port
          protocol      = "tcp"
        }
      ]

      environment = local.service_ports[var.service_name].environment
    }
  ])
}