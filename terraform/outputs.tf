output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.network.public_subnet_ids
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = module.compute.security_group_id
}

output "instance_ids" {
  description = "IDs of EC2 instances"
  value       = module.compute.instance_ids
}

output "instance_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = module.compute.instance_public_ips
}
output "instance_private_ips" {
  description = "Public IPs of EC2 instances"
  value       = module.compute.instance_private_ips
}
output "cloudwatch_dashboard_url" {
  description = "URL of the CloudWatch dashboard"
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${aws_cloudwatch_dashboard.main.dashboard_name}"
}