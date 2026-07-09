############################################
# Cognito User Pool
############################################

resource "aws_cognito_user_pool" "this" {
  name = "ecommerce-user-pool"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  schema {
    name                = "name"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }
}

############################################
# App Client (SPA)
############################################

resource "aws_cognito_user_pool_client" "this" {

  name         = "ecommerce-app"
  user_pool_id = aws_cognito_user_pool.this.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  supported_identity_providers = [
    "COGNITO"
  ]

callback_urls = [
  "https://${data.aws_ssm_parameter.cdn.value}"
]

logout_urls = [
  "https://${data.aws_ssm_parameter.cdn.value}"
]

  allowed_oauth_flows_user_pool_client = true

  allowed_oauth_flows = [
    "code"
  ]

  allowed_oauth_scopes = [
    "openid",
    "email",
    "profile"
  ]

  prevent_user_existence_errors = "ENABLED"

  access_token_validity  = 60
  id_token_validity      = 60
  refresh_token_validity = 30

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}