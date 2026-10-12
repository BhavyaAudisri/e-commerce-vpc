resource "aws_ssm_parameter" "ecr_image_urls" {
  for_each = aws_ecr_repository.ecr

  name        = "/ecommerce/${each.key}/image"
  description = "ECR image URI for ${each.key} service"
  type        = "String"

  value = "${each.value.repository_url}:latest"
}
