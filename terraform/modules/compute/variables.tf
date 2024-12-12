variable "ami" {
  description = "Main ami"
  type        = string

  default = ""
}

variable "node_type" {
  description = "Type of node you want to configure : controller, compute, boostrap"
  type        = string
}

locals {
  fedoracoreOS = "ami-011931490025934ea" # FedoraCoreOS v41

  boostrap_instance_type   = "t4g.xlarge" # CPU : 4 | RAM : 16GB
  controller_instance_type = "t4g.xlarge" # CPU : 4 | RAM : 16GB
  compute_instance_type    = "t4g.large"  # CPU : 2 | RAM : 8GB

  # For node type condition
  compute       = var.node_type == "compute" ? local.compute_instance_type : ""
  controller    = var.node_type == "controller" ? local.controller_instance_type : ""
  bootstrap     = var.node_type == "bootstrap" ? local.boostrap_instance_type : ""
  instance_type = coalesce(local.compute, local.controller, local.bootstrap)

}

variable "vpc_security_group_ids" {
  description = "Set of string of differents security attaches to the ec2 instance"
  type        = set(string)
}

variable "key_name" {
  description = "Key pair"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

