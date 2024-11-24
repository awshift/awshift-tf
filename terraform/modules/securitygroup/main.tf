resource "aws_security_group" "main" {
  name        = "${var.name_suffix}-sg"
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.name_suffix}-sg"
  }
}

