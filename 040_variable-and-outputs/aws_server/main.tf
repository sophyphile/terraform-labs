terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # provided by Hashicorp, not AWS
      version = "4.51.0"
    }
  }
}

variable "instance_type" {
  type = string
  description = "The size of the instance."
#   sensitive = true
  validation {
    condition = can(regex("^t2.",var.instance_type))
    error_message = "The instance must be a t3 type Ec2 instance"
  }
}

provider "aws" {
  # Configuration options
  region  = "eu-west-2"
}

locals {
  ami = "ami-084e8c05825742534"
}

data "aws_ami" "ubuntu" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "sami_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}

output "instance_ip_addr" {
  value = aws_instance.sami_server.public_ip
}
  