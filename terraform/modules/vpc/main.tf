resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "name" {
  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_cidr_block
}
