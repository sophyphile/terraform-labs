terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # provided by Hashicorp, not AWS
      version = "4.51.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = "eu-west-2"
}

locals {
  ami = "ami-084e8c05825742534"
}

resource "aws_instance" "sami_server" {
  ami           = "ami-08cd358d745620807"
  instance_type = "t2.micro"
  tags = {
    Name = "My-Server"
  }
  lifecycle {
    prevent_destroy = false
  }
}

output "instance_ip_addr" {
  value = aws_instance.sami_server.public_ip
}

