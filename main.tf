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

# Security Group - Renamed to todo_app_sg
resource "aws_security_group" "todo_app_sg" {
  name        = "todo-app-sg"
  description = "Allow SSH and HTTP traffic for Todo App"

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

# EC2 Instance - Using renamed SG
resource "aws_instance" "todo_app" {
  ami           = "ami-084568db4383264d4" # Ubuntu 24.04
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.todo_app_sg.id]  # Updated here

  tags = {
    Name = "TodoAppServer"
  }
}

# Output Public IP
output "public_ip" {
  value = aws_instance.todo_app.public_ip
}