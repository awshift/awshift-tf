module "worker_instances" {
  source = "./modules/compute"
  count  = 4

  name_prefix = "${var.name_prefix}-worker-${count.index}"
  key_name    = var.key_name

  ami           = var.ami
  instance_type = "t3a.large"
  vpc_id        = data.aws_vpc.default.id

  subnet_id = aws_subnet.private.id

  ingress_rules = [
    {
      description = "Metrics"
      from_port   = 10250
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    },
    {
      description = "The default ports that Kubernetes reserves"
      from_port   = 6443
      to_port     = 6443
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    },
    {
      description = ""
      from_port   = 9345
      to_port     = 9345
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    },
    {
      description = "Control Plane to Control Plane"
      from_port   = 2379
      to_port     = 2381
      ip_protocol = "tcp"
      source      = "0.0.0.0/0"
    },
    {
      description = "SSH connexion"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      source      = "0.0.0.0/0"
    },
    {
      description = "SSH connexion"
      from_port   = 0
      to_port     = 65000
      ip_protocol = "tcp"
      source      = "0.0.0.0/0"
  }]

  user_data = templatefile("./scripts/webapp.sh", {
    AWS_REGION            = var.AWS_REGION
    AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  })
}
