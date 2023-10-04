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
  for_each = {
    nano = "t2.nano"
    micro = "t2.micro"
    small = "t2.small"
  }
  ami           = "ami-08cd358d745620807"
  instance_type = each.value
  tags = {
    Name = "Server-${each.key}"
  }
}

output "instance_ip_addr" {
  value = values(aws_instance.sami_server)[*].public_ip
}

