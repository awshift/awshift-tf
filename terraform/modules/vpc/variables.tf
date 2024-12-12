variable "name_prefix" {
  description = "Name prefix for all ressources"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC cidr_block ipv4"
  type        = string
}

variable "subnet_cidr_block" {
  description = "Subnet cidr_block ipv4"
}
