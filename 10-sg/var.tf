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