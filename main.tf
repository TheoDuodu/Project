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

#creating a public subnet 1

resource "aws_subnet" "Project-public-subnet1" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project-public-subnet1"
  }
}


#creating a public subnet 2

resource "aws_subnet" "Project-public-subnet2" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project-public-subnet2"
  }
}


#creating a private subnet1

resource "aws_subnet" "Project-private-subnet1" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project-private-subnet1"
  }
}


#creating a private subnet2

resource "aws_subnet" "Project-private-subnet2" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project-private-subnet2"
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

#Associating public subnet1 with public route table

resource "aws_route_table_association" "Project-public-assoc1" {
  subnet_id      = aws_subnet.Project-public-subnet1.id
  route_table_id = aws_route_table.Project-public-RT.id
}

#Associating public subnet2 with public route table

resource "aws_route_table_association" "Project-public-assoc2" {
  subnet_id      = aws_subnet.Project-public-subnet2.id
  route_table_id = aws_route_table.Project-public-RT.id
}
#Associating private subnet1 with public route table

resource "aws_route_table_association" "Project-private-assoc1" {
  subnet_id      = aws_subnet.Project-private-subnet1.id
  route_table_id = aws_route_table.Project-private-RT.id
}

#Associating private subnet2 with public route table

resource "aws_route_table_association" "Project-private-assoc2" {
  subnet_id      = aws_subnet.Project-private-subnet2.id
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