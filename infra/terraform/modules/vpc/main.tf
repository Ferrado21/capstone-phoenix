# 1. Create the VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

# 2. Create the Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

# 3. Dynamic Data Source to fetch available AZs in eu-north-1
data "aws_availability_zones" "available" {
  state = "available"
}

# 4. Create Public Subnet 1 (Zone A)
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1) # e.g., 10.0.1.0/24
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-subnet-1"
    Environment = var.environment
  }
}

# 5. Create Public Subnet 2 (Zone B)
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 2) # e.g., 10.0.2.0/24
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-subnet-2"
    Environment = var.environment
  }
}

# 6. Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name        = "${var.environment}-public-rt"
    Environment = var.environment
  }
}

# 7. Associate Subnet 1 to Public Route Table
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# 8. Associate Subnet 2 to Public Route Table
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}
# # 9. Security Group for Compute Nodes (EC2 / K3s)
resource "aws_security_group" "compute_sg" {
  name        = "${var.environment}-compute-sg"
  description = "Allow inbound web and SSH traffic"
  vpc_id      = aws_vpc.main.id

  # SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In production, restrict this to your IP!
  }

  # HTTP Web Access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS Secure Web Access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules (Allow instances to talk out to the internet)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-compute-sg"
    Environment = var.environment
  }
}

# # 10. Security Group for the Database (RDS)
resource "aws_security_group" "db_sg" {
  name        = "${var.environment}-db-sg"
  description = "Allow inbound database traffic ONLY from compute nodes"
  vpc_id      = aws_vpc.main.id

  # Strictly allow traffic from the compute security group above
  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    cidr_blocks     = [var.my_public_ip]
    security_groups = [aws_security_group.compute_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-db-sg"
    Environment = var.environment
  }
}
variable "my_public_ip" {
  description = "My local public IP address for admin access"
  type        = string
}
