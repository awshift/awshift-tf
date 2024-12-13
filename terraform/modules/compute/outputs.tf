output "public_ips" {
  value = [for instance in aws_instance.main : instance.public_ip]
}
