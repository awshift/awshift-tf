output "master_private_ip" {
  value = module.master_instances[0].private_ips
}

output "workers_private_ips" {
  value = module.worker_instances[*].private_ips
}
