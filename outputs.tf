output "vpc_id" {
  description = "VPC ID"

  value = module.network.vpc_id
}

output "public_subnets" {
  description = "Public Subnets"

  value = module.network.public_subnets
}

output "private_subnets" {
  description = "Private Subnets"

  value = module.network.private_subnets
}
output "alb_security_group_id" {
  value = module.security.alb_sg_id
}

output "app_security_group_id" {
  value = module.security.app_security_group_id
}

output "redis_security_group_id" {
  value = module.security.redis_sg_id
}

output "efs_security_group_id" {
  value = module.security.efs_sg_id
}
output "bucket_name" {
  value = module.s3.bucket_name
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}
output "efs_id" {
  value = module.efs.efs_id
}

output "efs_dns_name" {
  value = module.efs.efs_dns_name
}
