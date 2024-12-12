resource "aws_instance" "main" {
  ami           = var.ami != "" ? var.ami : local.fedoracoreOS
  instance_type = local.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id




  # tags                   = var.common_tags
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    "Name" = var.instance_name
  }

}
