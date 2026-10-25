data "aws_s3_bucket" "ecommerce" {
  bucket = "ecommerce-frontend-1999b430"
}

data "aws_cloudfront_distribution" "cdn" {
  id = "E2KJ10URLBDUXC" # Your existing CloudFront Distribution ID
}