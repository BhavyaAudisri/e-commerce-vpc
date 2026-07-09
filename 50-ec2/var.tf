variable "project_name" {
    default = "ecommerce-vpc"
}
variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "ecommerce"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "zone_id" {
    default = "Z01955133DJD2Z4Y00KCI"
}

variable "domain_name" {
    default = "somisettibhavya.online"
}