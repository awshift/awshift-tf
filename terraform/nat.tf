resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = data.aws_subnet.public.id

  tags = {
    Name = "awshift-nat"
  }
}

resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "awshift-private-rt"
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = data.aws_subnets.default.ids[0]
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = data.aws_subnets.default.ids[1]
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = data.aws_subnets.default.ids[2]
  route_table_id = aws_route_table.private.id
}
