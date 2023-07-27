variable "deployment_name" {}
variable "aws_cli_profile" {}
variable "public_key" {}
variable "private_key" {}
variable "region" {}
variable "cidr_block" {}
variable "cidr_block_subnet" {}
variable "availability_zone" {}
variable "common_tags" {
  type = map(string)
}
variable "user" {     
  type = string
}

# Hetzner (hcloud) variables
variable "hcloud_public_key" {}
variable "hcloud_enabled" {}
variable "hcloud_token" {}
#variable "hcloud_server_count" {default = "1"}
variable "hcloud_private_key" {}
variable "hcloud_os_type" {}


