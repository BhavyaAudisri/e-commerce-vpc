resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "ecommerce" {
  bucket = "ecommerce-frontend-${random_id.bucket_suffix.hex}"
  force_destroy = true
}

# Block all public access

resource "aws_s3_bucket_public_access_block" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# Disable Versioning

resource "aws_s3_bucket_versioning" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

  versioning_configuration {
    status = "Disabled"
  }
}

# Enable Server-Side Encryption (SSE-S3)

resource "aws_s3_bucket_server_side_encryption_configuration" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.ecommerce.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}