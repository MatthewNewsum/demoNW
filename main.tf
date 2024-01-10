provider "aws" {
  region = var.region
}

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

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.100.1.0/24"

  tags = {
    Name = "MyVPC-PrivateSubnet"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.100.0.0/24"

  tags = {
    Name = "MyVPC-PublicSubnet"
  }
}

# resource "aws_route_table_association" "private_subnet_assoc" {
#   subnet_id      = aws_subnet.private_subnet_1.id
#   route_table_id = aws_route_table.private_route_table.id
# }

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# resource "aws_security_group" "ssh_sg" {
#   name        = "SSH_Security_Group"
#   description = "Allow SSH access"
#   vpc_id      = aws_vpc.my_vpc.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Adjust as needed for your specific requirements
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "SSH_Security_Group"
#   }
# }

# resource "aws_instance" "my_public_instance" {
#   ami           = "ami-0507f77897697c4ba"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.my_public_subnet.id
# #  availability_zone   = "us-west-2d"
#   key_name      = "OR001"
#   vpc_security_group_ids = [aws_security_group.ssh_sg.id]

#   tags = {
#     Name = "MyPublicEC2Instance"
#   }

#   associate_public_ip_address = true

# }

# resource "aws_instance" "my_private_instance" {
#   ami           = "ami-0507f77897697c4ba"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.my_private_subnet.id
# #  availability_zone   = "us-west-2d"
#   key_name      = "OR001"
#   vpc_security_group_ids = [aws_security_group.ssh_sg.id]

#   tags = {
#     Name = "MyPrivateEC2Instance"
#   }

# }