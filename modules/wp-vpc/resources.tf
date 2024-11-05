# Elastic IP
resource "aws_eip" "eip" {
  depends_on = [ module.wp-vpc ]
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  depends_on = [ module.wp-vpc ]
  allocation_id = aws_eip.eip.id
  subnet_id     = module.wp-vpc.public_subnets[0]

  tags = {
    Name = "wp-nat"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  depends_on = [ module.wp-vpc ]
  vpc_id = module.wp-vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.wp-vpc.igw_id
  }

  tags = {
    Name = "public-rt"
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  depends_on = [ module.wp-vpc ]
  vpc_id = module.wp-vpc.vpc_id  

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

# # Route Table Associations
# resource "aws_route_table_association" "public1" {
#   depends_on = [ module.wp-vpc ]
#   subnet_id      = module.wp-vpc.public_subnets[0]
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table_association" "public2" {
#   depends_on = [ module.wp-vpc ]
#   subnet_id      = module.wp-vpc.public_subnets[1]
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table_association" "private1" {
#   depends_on = [ module.wp-vpc ]
#   subnet_id      = module.wp-vpc.private_subnets[0]
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_route_table_association" "private2" {
#   depends_on = [ module.wp-vpc ]
#   subnet_id      = module.wp-vpc.private_subnets[1]
#   route_table_id = aws_route_table.private.id
# }

# Security Group for WordPress
resource "aws_security_group" "wordpress-sg" {
  depends_on = [ module.wp-vpc ]
  name        = "Allow SSH"
  description = "Allow SSH access to EC2 instances"
  vpc_id      = module.wp-vpc.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-sg"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  depends_on = [ module.wp-vpc ]
  name       = "rds-subnet-group"
  subnet_ids = [module.wp-vpc.private_subnets[0], module.wp-vpc.private_subnets[1]]

  tags = {
    Name = "rds-subnet-group"
  }
}

# RDS Security Group
resource "aws_security_group" "rds_security_group" {
  depends_on = [ module.wp-vpc ]
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = module.wp-vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.100.0.0/16"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}