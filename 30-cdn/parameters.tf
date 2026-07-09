resource "aws_ssm_parameter" "cloudfront_id" {
  name  = "/ecommerce/cdn_id"
  type  = "String"
  value = aws_cloudfront_distribution.cdn.id

  tags = {
    Project = "ecommerce"
  }
}