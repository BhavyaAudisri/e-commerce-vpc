variable "database_subnet_cidrs" {
  type = list(any)
  validation {
    condition     = length(var.database_subnet_cidrs) == 2
    error_message = "Please provide 2 valid database subnet CIDR"
  }
  default = ["10.10.21.0/24", "10.10.22.0/24"]
}