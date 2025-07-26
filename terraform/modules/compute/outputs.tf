

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.app.id
}

output "instance_ids" {
  description = "IDs of EC2 instances"
  value       = aws_instance.app[*].id
}

output "instance_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = aws_instance.app[*].public_ip
}
output "instance_private_ips" {
  description = "Public IPs of EC2 instances"
  value       = aws_instance.app[*].private_ip
}
output "cloudwatch_alarm_arns" {
  description = "ARNs of CloudWatch alarms"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu[*].arn
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.alerts.arn
}