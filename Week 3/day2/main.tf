###############################################
# Week 3 / Day 2 — main.tf
# - SG allowing SSH/HTTP
# - Amazon Linux 2023 AMI lookup (unless ami_id provided)
# - EC2 instance with simple user_data
###############################################

# Use the default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group for SSH (22) and HTTP (80)
resource "aws_security_group" "web" {
  name        = "w3d2-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "aws-fundamentals"
    Day     = "week3-day2"
  }
}

# Lookup latest Amazon Linux 2023 AMI (x86_64) unless ami_id provided
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# IMPORTANT: coalesce() treats "" as a value, so don't use it here.
# Pick var.ami_id if it's non-empty; else use the looked-up AL2023 AMI.
locals {
  effective_ami = length(trimspace(var.ami_id)) > 0 ? var.ami_id : data.aws_ami.al2023.id
}

# EC2 instance
resource "aws_instance" "web" {
  ami                    = local.effective_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail
    dnf -y update
    dnf -y install httpd
    systemctl enable --now httpd
    echo "Hello from user_data (will be overwritten by your SSH step)" > /var/www/html/index.html
  EOF

  tags = {
    Name    = "w3d2-web"
    Project = "aws-fundamentals"
    Day     = "week3-day2"
  }
}
