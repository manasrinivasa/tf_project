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
  region     = var.region
  access_key = var.aws_access_key 
  secret_key = var.aws_secret_key 
}

provider "hcloud" {
  token   = var.hcloud_token
}
