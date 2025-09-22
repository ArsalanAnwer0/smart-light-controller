provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "ami" {
  description = "AMI ID for Ubuntu 22.04 LTS"
  default     = "ami-0cfde0ea8edd312d4"
}

resource "aws_security_group" "smart_light_sg" {
  name        = "smart-light-sg"
  description = "Allow SSH and Flask traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.smart_light_sg.id]

  tags = {
    Name = "SmartLightController"
  }
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
