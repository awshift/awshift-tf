resource "aws_instance" "main" {
  for_each = tomap({
    for i, rule in var.file : i => rule
  })
  ami           = var.ami != "" ? var.ami : local.fedoracoreOS
  instance_type = local.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  user_data     = var.user_data

  provisioner "file" {
    source      = each.value.source
    destination = each.value.destination

    connection {
      type = "ssh"
      host = self.public_ip

      user        = each.value.user
      private_key = each.value.private_key_path
    }
  }

  # tags                   = var.common_tags
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    "Name" = var.instance_name
  }

}
