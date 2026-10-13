terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
      #version = "~> 5.84"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}