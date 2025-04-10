data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

resource "local_file" "inventory" {
  depends_on = [module.bastion_instance]
  filename   = "./inventory"

  content = templatefile("./scripts/inventory.tpl", {
    worker_ips = join("\n", module.worker_instances[*].private_ips)
    master_ips = module.master_instances[0].private_ips
  })
}
