module "vpc" {
  source = "./modules/vpc"

  cidr_block = var.cidr_block

  name_prefix           = var.name_prefix
  number_private_subnet = 1
  number_public_subnet  = 1
}
