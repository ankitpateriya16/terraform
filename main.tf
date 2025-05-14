provider "aws" {
  region = "us-east-1"
}
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
 
resource "aws_key_pair" "generated_key" {
  key_name   = "jenkins-key"
  public_key = tls_private_key.example.public_key_openssh
}


data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH, HTTP, Jenkins"
  vpc_id = data.aws_vpc.default.id
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    description = "Allow Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "example" {
  count         = 3
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  tags = {
    Name = var.instance_name[count.index]
  }
} 
