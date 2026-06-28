variable "project_name" {
  default = "ecommerce"
}

variable "environment" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "common_tags" {
  default = {
    Project     = "ecommerce"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "vpc_tags" {
  default = {
    Purpose = "assignment"
  }
}

variable "public_subnet_cidrs" {
  default = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.10.11.0/24", "10.10.12.0/24"]
  }

variable "database_subnet_cidrs" {
  default = ["10.10.21.0/24", "10.10.22.0/24"]
}
variable "public_subnet_tags" {
  default = {}
}
