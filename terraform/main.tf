data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_subnet" "private" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.64.0/20"

  tags = {
    Name = "private-subnet"
  }
}

# resource "local_file" "inventory" {
#   depends_on = [module.bastion_instance]
#   filename   = "./inventory"

#   content = templatefile("./scripts/inventory.tpl", {
#     worker_ips = join("\n", module.worker_instances[*].private_ips)
#     master_ips = module.master_instances[0].private_ips
#   })
# }
