resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { 
    Name = "devops-vpc" 
    Project     = var.project_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = { 
    Name = "${var.project_name}-igw"
    Project     = var.project_name
    }
}

resource "aws_subnet" "public" {
  count             = length(var.subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = var.az[count.index]
  map_public_ip_on_launch = true

  tags = { 
    Name = "${var.project_name}-public-subnet-${count.index + 1}" 
    Project     = var.project_name
    }
}

# resource "aws_network_acl" "public" {
#   vpc_id = aws_vpc.main.id
#   subnet_ids = [aws_subnet.public.id]
  
#   tags = {
#     Name = "${var.project_name}-public-acl" 
#     }
# }

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
    Project     = var.project_name
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(var.subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}