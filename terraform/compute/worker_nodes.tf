module "worker_instances" {
  source = "../modules/compute"
  count  = 3

  node_type = "compute"

  instance_name = "${var.name_prefix}-worker-node-${count.index + 1}"
  key_name      = var.key_name

  vpc_security_group_ids = [module.worker_sg.security_group_id]
  subnet_id              = data.aws_subnet.public.id
}

module "worker_sg" {
  source = "../modules/securitygroup"

  description = "Main security group for all worker nodes"
  vpc_id      = data.aws_vpc.main.id
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
