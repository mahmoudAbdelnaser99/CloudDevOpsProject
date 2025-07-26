variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "az" {
  description = "Availability zones"
  type        = list(string)
}
