resource "aws_ecs_cluster" "ecommerce" {
  name = "ecommerce-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

}
/* resource "aws_ecs_service" "ecommerce" {
  for_each = local.service_ports

  name            = "ecommerce-${each.key}-service"
  cluster         = aws_ecs_cluster.ecommerce.id
  task_definition = aws_ecs_task_definition.service[each.key].arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    security_groups  = [data.aws_ssm_parameter.ecommerce_ecs_sg.value]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = local.service_target_groups[each.key]
    container_name   = "${each.key}-service"
    container_port   = each.value.port
  }
  depends_on = [
    module.alb
  ] 
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
} */