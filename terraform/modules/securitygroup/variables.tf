variable "name_suffix" {
  description = "Name suffix for all of security groups resources"
  type        = string
}

variable "description" {
  description = "Description for the security group"
  type        = string
}

variable "vpc_id" {
  description = "" # TODO
  type        = string
}

variable "ingress_rules" {
  description = "Ingress for your current security group"
  type = object({
    description = optional(string)
    ip_protocol = optional(string, "tcp")
    to_port     = number
    from_port   = number
    source      = string
  })
}

variable "egress_rules" {
  description = "Egress for your current security group"
  type = object({
    description = optional(string)
    ip_protocol = optional(string, "tcp")
    to_port     = number
    from_port   = number
    destination = string
  })
}

locals {
  valid_cidr = "^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\/([0-9]|[1-2][0-9]|3[0-2])$"
}
