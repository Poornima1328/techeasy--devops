provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = true  
tags = {
    Name = "${var.env_name}-instance"
    Env  = var.env_name
  }

  user_data = templatefile("user_data4.sh", {
    env_name     = var.env_name,
    github_token = var.github_token
  })

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = var.key_name
}

resource "aws_security_group" "allow_ssh" {
  name        = "${var.env_name}-sg"
  description = "Allow SSH and HTTP access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
