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

  boostrap_instance_type   = "t3.xlarge" # CPU : 4 | RAM : 16GB
  controller_instance_type = "m5.large"  # CPU : 4 | RAM : 16GB
  compute_instance_type    = "t3.large"  # CPU : 2 | RAM : 8GB
  okd-admin_instance_type  = "t3.large"  # CPU : 2 | RAM : 8GB


  # For node type condition
  compute       = var.node_type == "compute" ? local.compute_instance_type : ""
  controller    = var.node_type == "controller" ? local.controller_instance_type : ""
  bootstrap     = var.node_type == "bootstrap" ? local.boostrap_instance_type : ""
  okd-admin     = var.node_type == "okd-admin" ? local.okd-admin_instance_type : ""
  instance_type = coalesce(local.compute, local.controller, local.bootstrap, local.okd-admin)

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

variable "file" {
  description = ""
  type = list(object({
    source           = string
    destination      = string
    user             = string
    private_key_path = string

  }))

  default = [{
    source           = ""
    destination      = ""
    user             = ""
    private_key_path = ""
  }]
}
