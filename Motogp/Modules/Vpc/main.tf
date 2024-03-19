resource "aws_vpc" "my_vpc_01" {
    cidr_block = var.cidr_block_vpc
    enable_dns_hostnames = true
tags={
    Name=var.vpc_name
}  
}


resource "aws_subnet" "my_public_subnet" {
    cidr_block = var.cidr_block_public_subnet
    vpc_id = aws_vpc.my_vpc_01.id
    availability_zone = "ap-northeast-3a"
    tags = {
      Name=var.public_subnet_name
    }
}



resource "aws_subnet" "My_private_subnet_name" {
    cidr_block = var.cidr_block_private_subnet
    vpc_id = aws_vpc.my_vpc_01.id
    availability_zone = "ap-northeast-3b"
    tags = {
      Name=var.private_subnet_name
    }
}



resource "aws_route_table" "My_public_route_table" {
    vpc_id = aws_vpc.my_vpc_01.id
    tags = {
      Name = var.my_public_rt_name
    }
}


resource "aws_route_table" "My_private_route_table" {
    vpc_id = aws_vpc.my_vpc_01.id
    tags = {
      Name = var.my_private_rt_name
    }
}

resource "aws_route_table_association" "my_public_rt_association" {
    route_table_id = aws_route_table.My_public_route_table.id
    subnet_id = aws_subnet.my_public_subnet.id
}

resource "aws_route_table_association" "My_private_route_table_association" {
    route_table_id = aws_route_table.My_private_route_table.id
    subnet_id = aws_subnet.My_private_subnet_name.id
}


resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc_01.id
    tags = {
      Name=var.my_igw_name
    }
}

resource "aws_route" "aws_table_attach" {
    route_table_id = aws_route_table.My_public_route_table.id
    gateway_id = aws_internet_gateway.my_igw.id
    destination_cidr_block = "0.0.0.0/0"
}