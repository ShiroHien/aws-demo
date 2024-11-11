output "vpc" {
  value = aws_vpc.vpc
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private_subnet[*].id
}
