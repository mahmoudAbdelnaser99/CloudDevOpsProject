variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

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



variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}
variable "ami_id" {
  type    = string
  default = "ami-084568db4383264d4"
}
