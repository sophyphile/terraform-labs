# terraform {
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "ExamPro"

#     workspaces {
#       name = "getting-started"
#     }
#   }

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "3.58.0"
#     }
#   }
# }

# locals {
#   project_name = "Andrew"
# }


resource "aws_instance" "sami_server" {
  ami           = "ami-084e8c05825742534"
  instance_type = var.instance_type
  tags = {
    Name = "MyServer-${local.project_name}"
  }
}

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "my-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }
# }


