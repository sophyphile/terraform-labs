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
  profile = "default"
  region  = "us-east-2"
  alias = "east"
}

provider "aws" {
  # Configuration options
  profile = "default"
  region  = "us-west-1"
  alias = "west"
}

data "aws_ami" "east-amazon-linux-2" {
 most_recent = true
 provider = aws.east
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

data "aws_ami" "west-amazon-linux-2" {
 most_recent = true
 provider = aws.west
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

resource "aws_instance" "sami_east_server" {
  ami = "${data.aws_ami.east-amazon-linux-2.id}"
  instance_type = "t2.micro"
  provider = aws.east
  tags = {
    Name = "Server-East"
  }
}

resource "aws_instance" "sami_west_server" {
  ami = "${data.aws_ami.west-amazon-linux-2.id}"
  instance_type = "t2.micro"
  provider = aws.west
  tags = {
    Name = "Server-West"
  }
}

output "east-instance_ip_addr" {
  value = aws_instance.sami_east_server.public_ip
}

output "west-instance_ip_addr" {
  value = aws_instance.sami_west_server.public_ip
}
