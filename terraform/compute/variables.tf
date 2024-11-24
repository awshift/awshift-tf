variable "region" {
  description = "Default AWS region for the project"
  type        = string

  # For this project, we need to use Stockholm region's
  default = "eu-north-1"
}

variable "profile" {
  description = "Variable for custom profile"
  type        = string

  default = "default"
}
