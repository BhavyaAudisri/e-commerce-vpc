variable "project_name" {
  default = "ecommerce-vpc"
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


variable "enable_dns_hostnames" {
  default = true
}

variable "igw_tags" {
  default = "ecommerce-igw"
}

variable "public_subnet_cidrs" {
  type = list(any)
  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Please provide 2 valid public subnet CIDR"
  }
   default = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(any)
  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Please provide 2 valid private subnet CIDR"
  }
  default = ["10.10.11.0/24", "10.10.12.0/24"]
}

variable "database_subnet_cidrs" {
  type = list(any)
  validation {
    condition     = length(var.database_subnet_cidrs) == 2
    error_message = "Please provide 2 valid database subnet CIDR"
  }
  default = ["10.10.21.0/24", "10.10.22.0/24"]
}