module "master_instances" {
  source = "./modules/compute"
  count  = 1

  name_prefix = "${var.name_prefix}-master"
  key_name    = var.key_name

  ami           = var.ami
  instance_type = "t3a.large"
  vpc_id        = data.aws_vpc.default.id

  subnet_id = data.aws_subnets.default.ids[0]

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
      to_port     = 6444
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
      description = "NodePort port range"
      from_port   = 30000
      to_port     = 32767
      ip_protocol = "tcp"
      source      = "0.0.0.0/0"
    }
  ]
}
