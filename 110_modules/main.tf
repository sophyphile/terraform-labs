terraform {

}

provider "aws" {
  # Configuration options
  region = "eu-west-2"
}

module "apache" {
  source = ".//terraform-aws-module-apache-example"
  vpc_id = "vpc-0c3ed2828aea24b6b"
  my_ip_with_cidr = "86.151.24.51/32"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOSoFeKt752pI1kpOKHj4JuaHNaFK2p6IF1QK02Y1M2W3PS0/ab5y664kmWph62ZvN30UAEWG74DmuOqlNP7nPYXXjccvDV60/0Y2+xNlt+FD6toPwnC1OTVZqa37Z4ZSZ0qCuCBwAq9k1Od0IHYNI46dF1vOIfbmGGeoPZjJA0owJbYXetjYwQxyV0avz5qGZ6D5UoxcuzmcbdX/Cf96tey1OMSjxk0JGhOGaHyoCpzcItsfx7oXhPJtSEySuoz5XxIU5lqCS+xyKvuXuFV8bxhme2/pUqJMKRkdTvcVTfApnIpnbndMbRw4sWd6BZ1p40illwyA3pKmHI3Jv3/C8OB1fSSo8PkZ9q1dG3gNaXZXekPWW+P6JiTnX3HGRdaPZ7CV4yfhovBO0mxoNf/7KB2AxFrrMcQgh7QnO3D5louSJVKPC+OVj0e4OfK4nDwCiQ6+1BbQ8zZrBAq4WlXoSwMCaScwsViqjrkLmCVD7Y8fjScUYvO2CgH7JaNfA+PU= sami@Samis-MacBook-Pro.local"
  instance_type = "t2.micro"
  server_name = "Apache Example Server"
}

output "public_ip" {
  value = module.apache.public_ip
}