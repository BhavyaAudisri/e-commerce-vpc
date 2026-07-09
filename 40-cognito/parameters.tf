resource "aws_ssm_parameter" "cognito_user_pool_id" {
  name  = "/ecommerce/cognito/user-pool-id"
  type  = "String"
  value = aws_cognito_user_pool.this.id

  tags = {
    Project = "ecommerce"
  }
}

resource "aws_ssm_parameter" "cognito_app_client_id" {
  name  = "/ecommerce/cognito/app-client-id"
  type  = "String"
  value = aws_cognito_user_pool_client.this.id

  tags = {
    Project = "ecommerce"
  }
}