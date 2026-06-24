terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
      #version = "~> 5.84"
    }
  }

  backend "s3" {
    bucket         = "ecomm-aws-vpc"
    key            = "ecomm-aws-vpctest" # you should have unique keys with in the bucket, same key should not be used in other repos or tf projects
    region         = "us-east-1"
    dynamodb_table = "ecomm-aws-vpc"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}