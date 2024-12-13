module "okd-admin_instances" {
  source = "../modules/compute"
  count  = 1

  node_type = "okd-admin"

  instance_name = "${var.name_prefix}-okd-admin-${count.index + 1}"
  key_name      = var.key_name

  vpc_security_group_ids = [module.okd-admin_sg.security_group_id]
  subnet_id              = data.aws_subnet.public.id

  user_data = "./scripts/user_data.sh"
}

module "okd-admin_sg" {
  source = "../modules/securitygroup"

  description = "okd sg"
  vpc_id      = ""
  name_prefix = "${var.name_prefix}-worker"

  ingress_rules = [
    {
      description = "Metrics"
      from_port   = 1936
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    },
    {
      description = "Host level services, including the node exporter on ports 9100-9101 and the Cluster Version Operator on port 9099."
      from_port   = 9000
      to_port     = 9999
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    },
    {
      description = "The default ports that Kubernetes reserves"
      from_port   = 10250
      to_port     = 10259
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    },
    {
      description = "openshift-sdn"
      from_port   = 10256
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    },
    {
      description = "Allow workers to communicate with the Kubernetes API server"
      from_port   = 6443
      to_port     = 6443
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    }
  ]
}