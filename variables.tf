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
