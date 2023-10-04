terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "terraform-associate-labs"

    workspaces {
      name = "getting-started"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws" # provided by Hashicorp, not AWS
      version = "4.51.0"
    }
  }
}

locals {
  project_name = "Sami"
}