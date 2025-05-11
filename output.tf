output "public_ip_1" {
  description = "Public IP address of the first instance"
  value       = aws_instance.instance_1.public_ip
}

output "public_ip_2" {
  description = "Public IP address of the second instance"
  value       = aws_instance.instance_2.public_ip
}
output "private_key_pem" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}
