output "Bastion" {
  value = module.bastion_instance.public_ips
}

output "Master Private IP" {
  value = module.master_instances[0].public_ips
}

output "Workers Private IP" {
  value = module.worker_instances[*].private_ips
}
