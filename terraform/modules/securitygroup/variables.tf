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
  default = "Ingress for your current security group"
  type = object({
    description = optional(string)
    ip_protocol = optional(string, "tcp")
    to_port     = number
    from_port   = number
    source      = string
  })
}
