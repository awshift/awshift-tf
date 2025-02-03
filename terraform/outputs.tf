output "master" {
  value = module.master_instances[0].public_ips
}
output "worker" {
  value = module.worker_instances[*].public_ips
}
output "bastion" {
  value = module.bastion_instance[*].public_ips
}
