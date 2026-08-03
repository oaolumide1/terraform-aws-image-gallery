#################################
# EC2 Outputs
#################################

output "instance_ids" {
  description = "EC2 Instance IDs"
  value       = aws_instance.app[*].id
}

output "private_ips" {
  description = "Private IP Addresses"
  value       = aws_instance.app[*].private_ip
}