resource "aws_vpc_security_group_egress_rule" "main" {
  # Default arguments
  security_group_id = aws_security_group.main.id
  ip_protocol       = var.egress_rules.ip_protocol
  description       = var.egress_rules.description

  # Destination parts, with multiple solutions (is a copypasta from ingress rules, with some differents)
  # If the egress source matches a valid CIDR
  cidr_ipv4 = regex(local.valid_cidr, var.egress_rules.source) != "" ? var.egress_rules.source : null
  # If the egress source starts with a security group ARN, it's valid
  referenced_security_group_id = startwith("sg-", var.egress_rules.source) ? var.egress_rules.source : null
}
