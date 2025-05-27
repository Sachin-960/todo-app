# Provider Configuration
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Variables
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "key_pair_name" {
  type = string
}

# EC2 Instance
resource "aws_instance" "todo_app" {
  ami           = "ami-084568db4383264d4" # Ubuntu 24.04
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  tags = {
    Name = "TodoAppServer"
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
}

# Security Group
resource "aws_security_group" "todo" {
  name = "todo"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
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

# Output Public IP
output "public_ip" {
  value = aws_instance.todo_app.public_ip
}