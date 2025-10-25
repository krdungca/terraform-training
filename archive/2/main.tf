terraform {
  required_providers {
    aws = {
      version = "~>5.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "terraform-bucket-udemy-10162025"
    key    = "backends/dev/project00.tfstate"
    region = "ap-southeast-1"
  }
}


provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "pj00-main-vpc"
  }
}

resource "aws_route_table" "main_rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "pj00-main-rtb"
  }
}

resource "aws_route_table_association" "main-rtb-assoc" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_rtb.id
}

resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "pj00-main-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "pj00-main-igw"
  }
}

resource "aws_instance" "ec2" {
  subnet_id = aws_subnet.main_subnet.id
  #ami                         = "ami-0933f1385008d33c4" #ephemeral free-tier ami
  ami                         = "ami-0e8c0174b6f004df5" #bitnami AMI
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "keypair4"
  vpc_security_group_ids      = [aws_security_group.pj00_main_sg.id]
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "pj00-ec2"
  }
}


resource "aws_security_group" "pj00_main_sg" {
  name   = "pj00-main-sg"
  vpc_id = aws_vpc.main.id
  # Ingress (Inbound) Rules
  # Allow all ICMP traffic (ping)
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ICMP (ping)"
  }

  # Allow SSH traffic from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
  }

  # Allow HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  # Allow HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS"
  }

  # Egress (Outbound) Rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "pj00-main-sg"
  }

}




output "output_details" {
  value = {
    vpc_id        = aws_vpc.main.id
    vpc_cidr      = aws_vpc.main.cidr_block
    subnet_id     = aws_subnet.main_subnet.id
    subnet_cidr   = aws_subnet.main_subnet.cidr_block
    igw_id        = aws_internet_gateway.gw.id
    ec2_id        = aws_instance.ec2.id
    ec2_public_ip = aws_instance.ec2.public_ip
    sg_id         = aws_security_group.pj00_main_sg.id
  }





  #end of TF block
}



