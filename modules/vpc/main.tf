provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "publicsubnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public1_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public1_az
}

resource "aws_subnet" "publicsubnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public2_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public2_az
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private1_cidr_block
  availability_zone = var.private1_az
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private2_cidr_block
  availability_zone = var.private2_az
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.main.id
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.public.id
}

