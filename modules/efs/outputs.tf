output "efs_id" {
  description = "Amazon EFS File System ID"
  value       = aws_efs_file_system.this.id
}

output "efs_dns_name" {
  description = "Amazon EFS DNS Name"
  value       = aws_efs_file_system.this.dns_name
}