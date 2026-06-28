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

  origin {
    domain_name              = data.aws_s3_bucket.ecommerce.bucket_regional_domain_name
    origin_id                = "frontend-s3-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    target_origin_id       = "frontend-s3-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  price_class = "PriceClass_100"
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
