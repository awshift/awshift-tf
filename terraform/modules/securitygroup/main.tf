resource "aws_security_group" "main" {
  name        = "${var.name_prefix}-sg"
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    "Name" = "${var.name_prefix}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "main" {
  for_each = tomap({
    for i, rule in var.ingress_rules : i => rule
  })

  security_group_id = aws_security_group.main.id

  # Optional arguments, thanks to default value 'tcp'
  ip_protocol = each.value.ip_protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port != null ? each.value.to_port : each.value.from_port

  # Source parts, with multiple solutions
  # If the ingress source matches a valid CIDR
  cidr_ipv4 = each.value.source != "" ? each.value.source : null

  # If self_reference is set to true, refereenced-sg will be the himself
  # Elsif the ingress source starts with a security group ARN, it's valid. 
  referenced_security_group_id = each.value.self_reference == true ? aws_security_group.main.id : (startswith("sg-", each.value.source) ? each.value.source : null)
}

resource "aws_vpc_security_group_egress_rule" "main" {
  security_group_id = aws_security_group.main.id
  description       = "Allow all outbound traffic"

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}


# resource "aws_vpc_security_group_egress_rule" "main" {
#   for_each = tomap({
#     for i, rule in var.ingress_rules : i => rule
#   })
#   # Default arguments
#   security_group_id = aws_security_group.main.id
#   ip_protocol       = each.value.ip_protocol
#   description       = each.value.description

#   # Destination parts, with multiple solutions (is a copypasta from ingress rules, with some differents)
#   # If the egress source matches a valid CIDR
#   cidr_ipv4 = regex(local.valid_cidr, each.value.source) != "" ? each.value.source : null

#   # If the egress source starts with a security group ARN, it's valid
#   referenced_security_group_id = startswith("sg-", each.value.source) ? each.value.source : null
# }
