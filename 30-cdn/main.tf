data "aws_caller_identity" "current" {}

############################
# Origin Access Control
############################

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "ecommerce-distribution-oac"
  description                       = "OAC for frontend S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

############################
# CloudFront Distribution
############################
resource "aws_cloudfront_distribution" "cdn" {

  enabled             = true
  comment             = "ecommerce-distribution"
  default_root_object = "index.html"

  price_class     = "PriceClass_All"
  is_ipv6_enabled = true
  http_version    = "http1.1"

  web_acl_id = "arn:aws:wafv2:us-east-1:250935839460:global/webacl/CreatedByCloudFront-a8a4954a/97f7576e-db5c-407b-ba74-00f9305cdd60"

  origin {
    domain_name              = "ecommerce-frontend-1488.s3.us-east-1.amazonaws.com"
    origin_id                = "bhavya-e-comm.s3.us-east-1.amazonaws.com-mqagy0ic898"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

    connection_attempts = 3
    connection_timeout  = 10
  }

  default_cache_behavior {

    target_origin_id       = "bhavya-e-comm.s3.us-east-1.amazonaws.com-mqagy0ic898"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    compress        = true
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  custom_error_response {
    error_code            = 403
    response_code         = 403
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  custom_error_response {
    error_code            = 404
    response_code         = 404
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
  }
}

############################
# Bucket Policy
############################

data "aws_iam_policy_document" "bucket_policy" {

  statement {
    sid    = "AllowCloudFrontServicePrincipal"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${data.aws_s3_bucket.ecommerce.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.cdn.arn
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "ecommerce" {
  bucket = data.aws_s3_bucket.ecommerce.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}