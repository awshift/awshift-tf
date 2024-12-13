output "okd_admin_ipaddress" {
  value = aws_instance.okd_admin.public_ip
}
