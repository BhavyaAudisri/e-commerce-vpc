variable "project_name" {
    default = "ecommerce-vpc"
}

variable "common_tags" {
    default = {
        Project = "ecommerce"
        Environment = "dev"
        Terraform = "true"
    }
}