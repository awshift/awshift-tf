module "bastion_instance" {
  source = "./modules/compute"
  count  = 0

  name_prefix = "${var.name_prefix}-bastion"
  key_name    = var.key_name

  ami           = var.ami
  instance_type = "t3.nano"
  vpc_id        = data.aws_vpc.default.id
  subnet_id     = element(data.aws_subnets.public.ids, count.index % length(data.aws_subnets.public.ids))

  ingress_rules = [
    {
      description = "SSH connexion"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      source      = "0.0.0.0/0"
    }
  ]

  user_data = templatefile("./scripts/webapp.sh", {
    AWS_REGION            = var.AWS_REGION
    AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  })
}
