resource "aws_vpc_security_group_ingress_rule" "main" {
  security_group_id = aws_security_group.main.id

  # Optional arguments, thanks to default value 'tcp'
  ip_protocol = var.ingress_rules.ip_protocol
  from_port   = var.ingress_rules.from_port
  to_port     = var.ingress_rules.to_port

  # Source parts, with multiple solutions
  # If the ingress source matches a valid CIDR
  cidr_ipv4 = regex(local.valid_cidr, var.ingress_rules.source) != "" ? var.ingress_rules.source : null
  # If the ingress source starts with a security group ARN, it's valid
  referenced_security_group_id = startwith("sg-", var.ingress_rules.source) ? var.ingress_rules.source : null
}
