resource "aws_apigatewayv2_api" "ecommerce_api" {
  name          = "ecommerce-api"
  description   = "eCommerce HTTP API"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]

    allow_methods = [
      "GET",
      "POST",
      "PUT",
      "DELETE",
      "OPTIONS"
    ]

    allow_headers = ["*"]

    expose_headers    = ["content-length"]
    max_age           = 300
    allow_credentials = false


  }
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.ecommerce_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_vpc_link" "ecommerce" {
  name = "ecommerce-vpc-link"

  subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  security_group_ids = [data.aws_ssm_parameter.vpclink_sg.value]

  tags = {
    Name        = "ecommerce-vpc-link"
    Environment = "dev"
  }
}

output "api_gateway_endpoint" {
  description = "eCommerce HTTP API endpoint"
  value       = aws_apigatewayv2_api.ecommerce_api.api_endpoint
}


resource "aws_apigatewayv2_integration" "alb" {
  api_id = aws_apigatewayv2_api.ecommerce_api.id

  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"

  integration_uri = data.aws_ssm_parameter.internal_alb_listener_arn.value

  connection_type = "VPC_LINK"
  connection_id   = aws_apigatewayv2_vpc_link.ecommerce.id

  payload_format_version = "1.0"

  timeout_milliseconds = 30000
}


resource "aws_apigatewayv2_route" "public_root" {
   api_id = aws_apigatewayv2_api.ecommerce_api.id 
   route_key = "GET /" 
   target = "integrations/${aws_apigatewayv2_integration.alb.id}" 
   authorization_type = "NONE" 
   }


resource "aws_apigatewayv2_route" "authenticated_proxy" { 
  api_id = aws_apigatewayv2_api.ecommerce_api.id 
  route_key = "ANY /{proxy+}" 
  target = "integrations/${aws_apigatewayv2_integration.alb.id}" 
  authorization_type = "JWT" 
  authorizer_id = aws_apigatewayv2_authorizer.cognito_jwt.id 
  }

resource "aws_apigatewayv2_route" "cors_preflight" { 
  api_id = aws_apigatewayv2_api.ecommerce_api.id 
  route_key = "OPTIONS /{proxy+}" 
  target = "integrations/${aws_apigatewayv2_integration.alb.id}" 
  authorization_type = "NONE" 
  }

resource "aws_apigatewayv2_authorizer" "cognito_jwt" { 
  api_id = aws_apigatewayv2_api.ecommerce_api.id 
  name = "cognito-jwt-authorizer" 
  authorizer_type = "JWT"

identity_sources = [ "$request.header.Authorization" ]

jwt_configuration {
  issuer = "https://cognito-idp.us-east-1.amazonaws.com/${data.aws_ssm_parameter.cognito_user_pool_id.value
}"

audience = [
  data.aws_ssm_parameter.cognito_user_pool_id.value
]

} 
}