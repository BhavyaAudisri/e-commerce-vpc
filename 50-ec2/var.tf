variable "project_name" {
  default = "ecommerce-vpc"
}
variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "ecommerce"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "zone_id" {
  default = "Z00800132GKOZ4W8NRKN4"
}

variable "domain_name" {
  default = "somisettibhavya.online"
}