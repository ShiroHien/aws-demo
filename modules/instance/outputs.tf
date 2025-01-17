output "public_ip" {
  value = aws_eip.eip.public_ip
}

output "private_ip" {
  value = aws_instance.server.private_ip
}

output "instance_id" {
  value = aws_instance.server.id
}
