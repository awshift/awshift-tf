output "bastion_public_ip" {
  value = module.bastion_instance.public_ips
}

output "master_private_ip" {
  value = module.master_instances[0].public_ips
}

output "workers_private_ips" {
  value = module.worker_instances[*].private_ips
}
