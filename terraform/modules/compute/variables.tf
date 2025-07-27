variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "IDs of subnets"
  type        = list(string)
}

variable "ami_id" {
  description = "UBUNTU" 
  type        = string
  default     = "ami-08a6efd148b1f7504" # Update for your region
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 4
}

variable "instance_names" {
  default = {
    0 = "jenkins-master"
    1 = "jenkins-slave"
    2 = "kubemaster"
    3 = "kubenode1"
  }
}