resource "aws_apigatewayv2_api" "ecommerce_api" {
  name          = "ecommerce-api"
  description   = "eCommerce HTTP API"
  protocol_type = "HTTP"
}

# Create the $default stage with auto-deploy
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.ecommerce_api.id
  name        = "$default"
  auto_deploy = true
}

# Output API endpoint
output "api_gateway_endpoint" {
  description = "eCommerce HTTP API endpoint"
  value       = aws_apigatewayv2_api.ecommerce_api.api_endpoint
}


resource "aws_api_gateway_vpc_link" "example" {
  name        = "ecommerce-vpc-link"
  description = "VPC Link for ecommerce internal ALB"
  subnet_ids = split( ",", data.aws_ssm_parameter.private_subnet_ids.value )

  security_group_ids = [ data.aws_ssm_parameter.vpclink_sg.value ] 
  tags = { 
    Name = "ecommerce-vpc-link" 
    Environment = "dev"
  } 
}