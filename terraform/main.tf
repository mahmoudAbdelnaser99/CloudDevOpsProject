module "network" {
  project_name  = var.project_name
  source        = "./modules/network"
  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
  az            = var.az
}


module "compute" {
  source         = "./modules/compute"
  project_name   = var.project_name
  subnet_id      = module.network.public_subnet_ids
  vpc_id         = module.network.vpc_id
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  instance_count = 2
}




# Create CloudWatch dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", module.compute.instance_ids[0]],
            ["AWS/EC2", "CPUUtilization", "InstanceId", module.compute.instance_ids[1]]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "EC2 CPU Utilization"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "NetworkIn", "InstanceId", module.compute.instance_ids[0]],
            ["AWS/EC2", "NetworkIn", "InstanceId", module.compute.instance_ids[1]]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "EC2 Network In"
        }
      }
    ]
  })
}

