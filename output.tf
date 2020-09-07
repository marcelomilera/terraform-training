output "host_public_dns" {
  value = aws_instance.example.public_dns
}

output "host_private_ip" {
  value = aws_instance.example.public_ip
}
