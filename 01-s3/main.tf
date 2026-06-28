resource "aws_s3_bucket" "ecommerce" {
  bucket = "ecommerce-frontend-1488"

}

# Block all public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
}
resource "aws_s3_bucket_public_access_block" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

}
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
}
resource "aws_s3_bucket_public_access_block" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# Disable Versioning

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
}

resource "aws_s3_bucket_versioning" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

  versioning_configuration {
    status = "Disabled"
  }
}

# Enable Server-Side Encryption (SSE-S3)

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
}
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
}


resource "aws_s3_bucket_server_side_encryption_configuration" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}