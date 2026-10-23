resource "aws_apigatewayv2_api" "ecommerce_api" {
   name = "ecommerce-api" 
   description = "eCommerce HTTP API" protocol_type = "HTTP"

cors_configuration { 
  allow_origins = [ 
    "https://d39l59e450oqcc.cloudfront.net", 
    "https://somisettibhavya.online" ]

allow_methods = [
  "GET",
  "POST",
  "PUT",
  "DELETE",
  "OPTIONS"
]

allow_headers = [
  "authorization",
  "content-type",
  "x-amz-date",
  "x-amz-security-token",
  "x-api-key"
]

expose_headers     = ["content-length"]
max_age            = 300
allow_credentials  = false


} 
}

resource "aws_apigatewayv2_stage" "default" { 
  api_id = aws_apigatewayv2_api.ecommerce_api.id
  name = "$default" auto_deploy = true 
  }

resource "aws_apigatewayv2_vpc_link" "ecommerce" { 
  name = "ecommerce-vpc-link"

subnet_ids = split( ",", data.aws_ssm_parameter.private_subnet_ids.value )

security_group_ids = [ data.aws_ssm_parameter.vpclink_sg.value ]

tags = { 
  Name = "ecommerce-vpc-link" 
  Environment = "dev" 
  } 
  }

output "api_gateway_endpoint" {
   description = "eCommerce HTTP API endpoint"
   value = aws_apigatewayv2_api.ecommerce_api.api_endpoint
    }