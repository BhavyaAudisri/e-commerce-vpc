data "aws_s3_bucket" "ecommerce" {
  bucket = "ecommerce-frontend-1488"
}

data "aws_cloudfront_distribution" "cdn" {
  id = "E31O3QJA5R0U02" # Your existing CloudFront Distribution ID
}