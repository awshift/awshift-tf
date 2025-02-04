# resource "aws_instance" "okd_admin" {
#   ami                    = "ami-0c8bf1ee5b07dcb22"
#   instance_type          = "t3.large"
#   key_name               = var.key_name
#   subnet_id              = module.vpc.public_subnet[0].id
#   vpc_security_group_ids = [module.okd-admin_sg.security_group_id]
#   user_data              = file("./scripts/user_data.sh")

#   provisioner "file" {
#     source      = "./file/awshift-keypair.pem"
#     destination = "/home/ec2-user/awshift.pem"
#     connection {
#       type        = "ssh"
#       host        = self.public_ip
#       user        = "ec2-user"
#       private_key = file("./file/awshift-keypair.pem")
#     }
#   }

#   provisioner "file" {
#     source      = "./file/install-config.yaml"
#     destination = "/home/ec2-user/install-config.yaml"
#     connection {
#       type        = "ssh"
#       host        = self.public_ip
#       user        = "ec2-user"
#       private_key = file("./file/awshift-keypair.pem")
#     }
#   }

#   provisioner "file" {
#     source      = "./file/prepare.sh"
#     destination = "/home/ec2-user/prepare.sh"
#     connection {
#       type        = "ssh"
#       host        = self.public_ip
#       user        = "ec2-user"
#       private_key = file("./file/awshift-keypair.pem")
#     }
#   }

#   tags = {
#     "Name" = "${var.name_prefix}-okd-admin"
#   }
# }


# module "okd-admin_sg" {
#   source = "./modules/securitygroup"

#   description = "okd sg"
#   vpc_id      = module.vpc.vpc.id
#   name_prefix = "${var.name_prefix}-okdadmin"

#   ingress_rules = [
#     {
#       description = "Metrics"
#       from_port   = 1936
#       ip_protocol = "tcp"

#       source = "0.0.0.0/0"
#     },
#     {
#       description = "Host level services, including the node exporter on ports 9100-9101 and the Cluster Version Operator on port 9099."
#       from_port   = 9000
#       to_port     = 9999
#       ip_protocol = "tcp"

#       source = "0.0.0.0/0"
#     },
#     {
#       description = "The default ports that Kubernetes reserves"
#       from_port   = 10250
#       to_port     = 10259
#       ip_protocol = "tcp"

#       source = "0.0.0.0/0"
#     },
#     {
#       description = "openshift-sdn"
#       from_port   = 10256
#       ip_protocol = "tcp"

#       source = "0.0.0.0/0"
#     },
#     {
#       description = "Allow workers to communicate with the Kubernetes API server"
#       from_port   = 6443
#       to_port     = 6443
#       ip_protocol = "tcp"

#       source = "0.0.0.0/0"
#     },
#     {
#       description = "Allows SSH"
#       from_port   = 22
#       ip_protocol = "tcp"

#       source = "0.0.0.0/0"
#     },
#     {
#       description = "Allows HTTP"
#       from_port   = 80
#       ip_protocol = "tcp"

#       source = "0.0.0.0/0"
#     }
#   ]
# }
