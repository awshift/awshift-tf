module "vpc" {
  source = "./modules/vpc"

  cidr_block = var.cidr_block

  name_prefix           = var.name_prefix
  number_private_subnet = 1
  number_public_subnet  = 1
}

resource "local_file" "inventory" {
  depends_on = [module.bastion_instance]
  filename   = "./inventory"

  content = templatefile("./scripts/inventory.tpl", {
    worker_ips = join("\n", module.worker_instances[*].private_ips)
    master_ips = module.master_instances[0].private_ips
  })

  # provisioner "file" {
  #   source      = "./inventory"
  #   destination = "/home/ubuntu/inventory"
  # }

  # connection {
  #   type        = "ssh"
  #   host        = module.bastion_instance.public_ips
  #   user        = "ubuntu"
  #   private_key = file("./scripts/awshift.pem")
  # }
}
