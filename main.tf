provider "aws" {
    region = var.region
}

resource "aws_vpc" "ak-vpc" {
    cidr_block = var.cidr_block[0]
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags = {
      Name = "class-vpc"
    }
}

resource "aws_subnet" "ak-subnet-01" {
    vpc_id = aws_vpc.ak-vpc.id
    availability_zone = var.availability_zone[0]
    cidr_block = var.cidr_block[1]

    tags = {
      Name = "class-privatesubnet"
    }
}

resource "aws_subnet" "ak-subnet-02" {
    vpc_id = aws_vpc.ak-vpc.id
    availability_zone = var.availability_zone[1]
    cidr_block = var.cidr_block[2]
    map_public_ip_on_launch = true

    tags = {
      Name = "class-publicsubnet"
    }
}

resource "aws_security_group" "ak-sg" {
  name = "websever-sg"
  description = "allow http and ssh traffic"
  vpc_id = aws_vpc.ak-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "new-sg"
  }
}