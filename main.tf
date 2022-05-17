# creating VPC for a project

resource "aws_vpc" "Project-VPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Project-VPC"
  }
}

#creating a public subnet

resource "aws_subnet" "Project-public-subnet" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project-public-subnet"
  }
}

#creating a private subnet

resource "aws_subnet" "Project-private-subnet" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project-private-subnet"
  }
}

#creating a public route table

resource "aws_route_table" "Project-public-RT" {
  vpc_id = aws_vpc.Project-VPC.id

  tags = {
    Name = "Project-public-RT"
  }
}

#creating a private route table

resource "aws_route_table" "Project-private-RT" {
  vpc_id = aws_vpc.Project-VPC.id

  tags = {
    Name = "Project-private-RT"
  }
}

#Associating public subnet with public route table

resource "aws_route_table_association" "Project-public-assoc" {
  subnet_id      = aws_subnet.Project-public-subnet.id
  route_table_id = aws_route_table.Project-public-RT.id
}

#Associating private subnet with public route table

resource "aws_route_table_association" "Project-private-assoc" {
  subnet_id      = aws_subnet.Project-private-subnet.id
  route_table_id = aws_route_table.Project-private-RT.id
}

#Internet gateway

resource "aws_internet_gateway" "Project-IGW" {
  vpc_id = aws_vpc.Project-VPC.id

  tags = {
    Name = "Project-IGW"
  }
}

#Associating public route table with Internet gateway

resource "aws_route" "Project-IGW-assoc" {
  route_table_id         = aws_route_table.Project-public-RT.id
  gateway_id             = aws_internet_gateway.Project-IGW.id
  destination_cidr_block = "0.0.0.0/0"

}