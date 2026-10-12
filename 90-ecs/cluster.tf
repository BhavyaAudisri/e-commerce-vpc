resource "aws_ecs_cluster" "ecommerce" {
  name = "ecommerce-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

}