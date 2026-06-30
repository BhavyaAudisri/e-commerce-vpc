/* resource "aws_ecr_repository" "products" {
  name                 = "ecommerce/product_service"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "cart" {
  name                 = "ecommerce/cart_service"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "user" {
  name                 = "ecommerce/user_service"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "order" {
  name                 = "ecommerce/order_service"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "product_service" {

  depends_on = [
    aws_ecr_repository.products
  ]

  provisioner "local-exec" {
    command = <<EOT
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.ecommerce/product_service.repository_url}

docker build -t ecommerce/product_service ../ecommerce/product_service

docker tag ecommerce/product_service:latest ${aws_ecr_repository.products.repository_url}:latest

docker push ${aws_ecr_repository.ecommerce/product_service.repository_url}:latest
EOT
  }
}
 */

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