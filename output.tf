output "public_ips" {
  value = aws_instance.example[*].public_ip
}
output "private_key_pem" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}
