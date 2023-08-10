terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    hcloud = { 
      source = "hetznercloud/hcloud"
      version = "1.33.1"
      
    }
  }
}
provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = var.aws_cli_profile
}

provider "hcloud" {
  token   = var.hcloud_token
}
