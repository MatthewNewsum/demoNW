

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.100.0.0/16"

  tags = {
    Name = "Demo_VPC"
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "DemoIGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.100.0.0/24"

  tags = {
    Name = "MyVPC-PublicSubnet"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}
