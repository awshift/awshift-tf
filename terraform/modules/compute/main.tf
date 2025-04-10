resource "aws_instance" "main" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data              = var.user_data

  tags = {
    "Name" = "${var.name_prefix}-node"
  }
}

resource "aws_security_group" "main" {
  name   = "${var.name_prefix}-sg"
  vpc_id = var.vpc_id

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
