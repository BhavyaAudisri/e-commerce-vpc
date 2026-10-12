resource "aws_ecr_repository" "ecr" {
  for_each = local.services

  name                 = each.value.repo
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}