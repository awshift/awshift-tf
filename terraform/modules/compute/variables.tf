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
  ubuntuOS = "ami-09a9858973b288bdd" # Ubuntu 24.04

  boostrap_instance_type   = "t3.xlarge" # CPU : 4 | RAM : 16GB
  controller_instance_type = "m5.large"  # CPU : 4 | RAM : 16GB
  compute_instance_type    = "t3.large"  # CPU : 2 | RAM : 8GB
  # okd-admin_instance_type  = "t3.large"  # CPU : 2 | RAM : 8GB


  # For node type condition
  compute    = var.node_type == "compute" ? local.compute_instance_type : ""
  controller = var.node_type == "controller" ? local.controller_instance_type : ""
  bootstrap  = var.node_type == "bootstrap" ? local.boostrap_instance_type : ""
  # okd-admin     = var.node_type == "okd-admin" ? local.okd-admin_instance_type : ""
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

variable "instance_name" {
  description = "Instance name"
  type        = string
}

variable "user_data" {
  description = "User data"
  type        = string
  default     = ""
}
