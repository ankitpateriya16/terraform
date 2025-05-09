output "public_ips" {
  description = "Public IPs of all EC2 instances"
  value       = [for instance in aws_instance.example : instance.public_ip]
}
 
output "private_ips" {
  description = "Private IPs of all EC2 instances"
  value       = [for instance in aws_instance.example : instance.private_ip]
}
output "private_key_pem" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}
