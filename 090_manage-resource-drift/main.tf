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

resource "aws_instance" "sami_server" {
  ami           = "ami-08cd358d745620807"
  instance_type = "t2.micro"
  tags = {
    Name = "MyServer"
  }
}

resource "aws_s3_bucket" "sami_bucket" {
  bucket = "my-new-bucket-24345t1"
}

output "instance_ip_addr" {
  value = aws_instance.sami_server.public_ip
}

