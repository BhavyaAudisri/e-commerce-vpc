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