resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.dev_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "dev_vpc"
  }
}

resource "aws_subnet" "dev_subnet_1" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = var.dev_subnet1_cidr
  availability_zone = var.avail_zone

  tags = {
    Name = "dev_subnet1"
  }
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id     = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev_igw"
  }  
}

resource "aws_default_route_table" "dev_rtb" {
  default_route_table_id = aws_vpc.dev_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }  
  tags = {
    Name = "dev_rtb"
  }  
}