variable "region" {
  description = "default region"
  type        = string

  default = "eu-north-1"
}

variable "name_prefix" {
  description = "Name prefix for all ressources"
  type        = string

  default = "awshift"
}

variable "vpc_cidr_block" {
  description = "VPC cidr_block ipv4"
  type        = string

  default = "192.168.10.0/24"
}

variable "map_public_ip_on_launch" {
  description = "Public Subnet or not"
  type        = bool

  default = false
}

variable "number_public_subnet" {
  description = "Number of public subnet you want"
  type        = number

  default = 1
}

variable "number_private_subnet" {
  description = "Number of public subnet you want"
  type        = number

  default = 1
}

locals {
  total_subnets = ceil(log(var.number_private_subnet + var.number_public_subnet, 2) / log(2, 2))
}
