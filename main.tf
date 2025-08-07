provider "aws" {
  region = "ap-southeast-2"  # Change as needed
}

resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1
  instance_type = "t2.micro"
  key_name      = "foriacdemo"               # Change to your existing key pair name

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  subnet_id = data.aws_subnet.default.id

  tags = {
    Name = "Public-EC2"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (change this in production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  filter {
    name   = "publicsubnet"
    values = ["true"]
  }

  availability_zone = data.aws_availability_zones.available.names[0]
}

data "aws_availability_zones" "available" {}
