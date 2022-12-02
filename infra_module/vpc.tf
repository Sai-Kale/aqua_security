################################################################################
# VPC
################################################################################

# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = var.app_name
  }
}



######## IGW  ############
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.app_name
  }
}



####### public subnets #######
resource "aws_subnet" "public_subnet" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = format("public-subnet-eks-%s", element(var.azs, count.index))
  }
}



############ private subnets #############
resource "aws_subnet" "private_subnet" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = format("private-subnet-eks-%s", element(var.azs, count.index))
  }
}

########## public route tables ################
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "${var.app_name}-public-route-table"
  }
}

#### route table associations public  #######
resource "aws_route_table_association" "main-public-1-a" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.main-public.id
}



