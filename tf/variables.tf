# General variables
variable "deployment_name" {}
variable "user" {     
  type = string
}
variable "public_key" {}
variable "private_key" {}

# AWS variables
variable "aws_secret_key" {}
variable "aws_access_key" {}
variable "region" {}
variable "cidr_block" {}
variable "cidr_block_subnet" {}
variable "availability_zone" {}
variable "common_tags" {
  type = map(string)
}

# Hetzner (hcloud) variables
variable "hcloud_enabled" {}
variable "hcloud_token" {}
#variable "hcloud_server_count" {default = "1"}
variable "hcloud_os_type" {}
variable "hcloud_server_type" {}
variable "hcloud_location" {}

