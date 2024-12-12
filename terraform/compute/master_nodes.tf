module "master_instances" {
  source = "../modules/compute"
  count  = 2

  node_type = "controller"

  instance_name = "${var.name_prefix}-master-node-${count.index + 1}"
  key_name      = var.key_name

  vpc_security_group_ids = [module.master_sg.security_group_id]
  subnet_id              = ""
}

module "master_sg" {
  source = "../modules/securitygroup"

  description = "Main security group for all of master nodes"
  vpc_id      = ""
  name_prefix = "${var.name_prefix}-master"

  ingress_rules = [
    {
      description = "Metrics"
      from_port   = 1936
      ip_protocol = "tcp"

      source = "0.0.0.0/0"
    },
    { # 
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
  }]

  # egress_rules = [{
  #   description = ""
  #   ip_protocol = "-1"
  #   from_port   = 0
  #   destination = "0.0.0.0/0"
  # }]
}
