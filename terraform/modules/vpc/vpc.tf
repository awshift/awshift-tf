resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "public" {
  count      = var.number_public_subnet
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, local.total_subnets, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name             = "${var.name_prefix}-public_subnet-${count.index + 1}"
    "awshift:public" = "true"

  }
}

resource "aws_subnet" "private" {
  count      = var.number_public_subnet
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, local.total_subnets, count.index + var.number_public_subnet)

  tags = {
    Name             = "${var.name_prefix}-private_subnet-${count.index + 1}"
    "awshift:public" = "false"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.name_prefix}-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.number_public_subnet
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
