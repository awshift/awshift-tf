variable "AWS_REGION" { default = "" }
variable "AWS_ACCESS_KEY_ID" { default = "" }
variable "AWS_SECRET_ACCESS_KEY" { default = "" }

variable "region" {
  description = "Default AWS region for the project"
  type        = string
  # For this project, we need to use Stockholm region
  default = "eu-west-3"
}

variable "profile" {
  description = "Variable for custom profile"
  type        = string

  default = "default"
}

variable "name_prefix" {
  description = "Name prefix for all ressources"
  type        = string

  default = "awshift"
}

variable "key_name" {
  description = "Default keypair for all instances"
  type        = string

  default = "awshift-keypair"
}

variable "ami" {
  description = "Default ami for all instances"
  type        = string

  default = "ami-0160e8d70ebc43ee1"
}
