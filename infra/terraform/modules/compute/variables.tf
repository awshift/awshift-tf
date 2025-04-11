variable "name_prefix" {
  description = "Value to prefix the name of the instance"
  type        = string
}

variable "ami" {
  description = "Main ami"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "key_name" {
  description = "Key pair"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "user_data" {
  description = "User data"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.nano"
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description    = string
    from_port      = number
    to_port        = optional(number)
    ip_protocol    = string
    source         = string
    self_reference = optional(bool)
  }))
  default = []
}
