# TODO: Create map of subnets ids and ips (if possible), public and private

output "vpc" {
  value = aws_vpc.main
}

output "public_subnet" {
  value = aws_subnet.public
}

output "private_subnet" {
  value = aws_subnet.private
}

output "subnet_ids" {
  value = concat(aws_subnet.private[*].id, aws_subnet.public[*].id)
}
