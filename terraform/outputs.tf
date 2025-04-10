output "bastion" {
  value = module.bastion_instance[0].public_ips
}

output "master" {
  value = module.master_instances[0].public_ips
}
output "worker" {
  value = module.worker_instances[*].private_ips
}
