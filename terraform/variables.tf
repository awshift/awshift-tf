variable "region" {
  description = "Default AWS region for the project"
  type        = string
  # For this project, we need to use Stockholm region
  default = "eu-north-1"
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
