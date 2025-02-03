output "master" {
  value = module.master_instances[0].private_ips
}
output "worker" {
  value = module.worker_instances[*].private_ips
}
output "bastion" {
  value = module.bastion_instance[*].public_ips
}
