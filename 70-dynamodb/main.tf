resource "aws_dynamodb_table" "products" {
  name         = "ecommerce-products"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "product_id"

  attribute {
    name = "product_id"
    type = "S"
  }

  tags = {
    Name = "ecommerce-products"
  }
}

resource "aws_dynamodb_table" "cart" {
  name         = "ecommerce-cart"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  tags = {
    Name = "ecommerce-cart"
  }
}