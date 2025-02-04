resource "aws_instance" "main" {
  ami                    = var.ami != "" ? var.ami : local.ubuntuOS
  instance_type          = local.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data              = var.user_data

  tags = {
    "Name" = var.instance_name
  }
}
