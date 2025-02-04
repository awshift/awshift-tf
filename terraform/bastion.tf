module "bastion_instance" {
  source = "./modules/compute"

  node_type = "bastion"

  instance_name = "${var.name_prefix}-bastion-node"
  key_name      = var.key_name

  vpc_security_group_ids = [module.bastion_sg.security_group_id]
  subnet_id              = module.vpc.public_subnet[0].id
  user_data = templatefile("./scripts/webapp.sh", {
    AWS_REGION            = var.AWS_REGION
    AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  })
}

# resource "null_resource" "bastion_keypair" {
#   provisioner "file" {
#     source      = "./scripts/awshift.pem"
#     destination = "/home/ubuntu/awshift.pem"
#   }

#   connection {
#     type        = "ssh"
#     host        = module.bastion_instance.public_ips
#     user        = "ubuntu"
#     private_key = file("./scripts/awshift.pem")
#   }
# }

module "bastion_sg" {
  source = "./modules/securitygroup"

  description = "Main security group for bastion node"
  vpc_id      = module.vpc.vpc.id
  name_prefix = "${var.name_prefix}-bastion"

  ingress_rules = [
    {
      description = "SSH connexion"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      source      = "0.0.0.0/0"
    }
  ]
}
