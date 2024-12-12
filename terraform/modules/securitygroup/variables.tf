variable "name_prefix" {
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
  description = "List of ingress rules for your current security group"
  type = list(object({
    description    = optional(string)
    ip_protocol    = optional(string, "tcp")
    from_port      = number
    to_port        = optional(number, null)
    source         = optional(string, "")
    self_reference = optional(bool, false)
  }))
}

# variable "egress_rules" {
#   description = "Egress for your current security group"
#   type = list(object({
#     description = optional(string)
#     ip_protocol = optional(string, "tcp")
#     from_port   = number
#     to_port     = optional(number, null)
#     destination = optional(string, "")
#     # self_reference = optional(bool, false)
#   }))
# }

locals {
  valid_cidr = "^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\\/([0-9]|[1-2][0-9]|3[0-2])$"
}
