terraform {
  cloud {
    organization = "terraform-associate-labs"

    workspaces {
      name = "force-unlocking"
    }
  }
}

module "apache" {
  source  = "sophyphile/apache-example/aws"
  version = "1.1.0"
  vpc_id = var.vpc_id
  my_ip_with_cidr = var.my_ip_with_cidr
  public_key = var.public_key
  instance_type = var.instance_type
  server_name = var.server_name
}

output "public_ip" {
  value = module.apache.public_ip
}