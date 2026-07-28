resource "aws_ecr_repository" "ecr" {
  for_each = local.services

  name                 = each.value.repo
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "push_images" {
  for_each = local.services

  depends_on = [aws_ecr_repository.ecr]

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]

    command = <<EOT
aws ecr get-login-password --region ${local.region} | docker login --username AWS --password-stdin ${aws_ecr_repository.ecr[each.key].repository_url}

docker build -t ${each.value.repo}:latest ${each.value.path}

docker tag ${each.value.repo}:latest ${aws_ecr_repository.ecr[each.key].repository_url}:latest

docker push ${aws_ecr_repository.ecr[each.key].repository_url}:latest
EOT
  }
}