resource "aws_security_group" "main" {
  name        = "${var.name_prefix}-sg"
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.name_prefix}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "main" {
  security_group_id = aws_security_group.main.id

  # Optional arguments, thanks to default value 'tcp'
  ip_protocol = var.ingress_rules.ip_protocol
  from_port   = var.ingress_rules.from_port
  to_port     = var.ingress_rules.to_port != null ? var.ingress_rules.to_port : var.ingress_rules.from_port

  # Source parts, with multiple solutions
  # If the ingress source matches a valid CIDR
  cidr_ipv4 = regex(local.valid_cidr, var.ingress_rules.source) != "" ? var.ingress_rules.source : null

  # If self_reference is set to true, refereenced-sg will be the himself
  # Elsif the ingress source starts with a security group ARN, it's valid. 
  referenced_security_group_id = var.ingress_rules.self_reference == true ? aws_security_group.main.id : (startwith("sg-", var.ingress_rules.source) ? var.ingress_rules.source : null)
}


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
