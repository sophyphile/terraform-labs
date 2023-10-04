terraform {
  # cloud {
  #   organization = "terraform-associate-labs"

  #   workspaces {
  #     name = "provisioners"
  #   }
  # }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.51.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-west-2"
}

data "aws_vpc" "main" {
  id = "vpc-0c3ed2828aea24b6b"
}

resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "MyServer Security Group"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["86.160.127.204/32"]
    ipv6_cidr_blocks = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "sami_server" {
  ami           = "ami-084e8c05825742534"
  instance_type = "t2.micro"
  tags = {
    Name = "MyServer"
  }
  key_name = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data = data.template_file.user_data.rendered

  provisioner "file" {
    content     = "mars"
    destination = "/home/ec2-user/barsoon.txt"
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("/Users/sami/.ssh/terraform2023")}"
    host     = self.public_ip
    }
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOSoFeKt752pI1kpOKHj4JuaHNaFK2p6IF1QK02Y1M2W3PS0/ab5y664kmWph62ZvN30UAEWG74DmuOqlNP7nPYXXjccvDV60/0Y2+xNlt+FD6toPwnC1OTVZqa37Z4ZSZ0qCuCBwAq9k1Od0IHYNI46dF1vOIfbmGGeoPZjJA0owJbYXetjYwQxyV0avz5qGZ6D5UoxcuzmcbdX/Cf96tey1OMSjxk0JGhOGaHyoCpzcItsfx7oXhPJtSEySuoz5XxIU5lqCS+xyKvuXuFV8bxhme2/pUqJMKRkdTvcVTfApnIpnbndMbRw4sWd6BZ1p40illwyA3pKmHI3Jv3/C8OB1fSSo8PkZ9q1dG3gNaXZXekPWW+P6JiTnX3HGRdaPZ7CV4yfhovBO0mxoNf/7KB2AxFrrMcQgh7QnO3D5louSJVKPC+OVj0e4OfK4nDwCiQ6+1BbQ8zZrBAq4WlXoSwMCaScwsViqjrkLmCVD7Y8fjScUYvO2CgH7JaNfA+PU= sami@Samis-MacBook-Pro.local"
}

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}

output "public_ip" {
  value = aws_instance.sami_server.public_ip
}