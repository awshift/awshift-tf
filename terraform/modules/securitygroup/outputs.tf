output "security_group_id" {
  description = "The ID of the current security group"
  value       = aws_security_group.main.id
  sensitive   = true
}

output "security_group_arn" {
  description = "The arn of the current security group"
  value       = aws_security_group.main.arn
  sensitive   = true
}
