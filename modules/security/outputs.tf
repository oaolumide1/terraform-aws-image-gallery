output "alb_sg_id" {
  value = module.alb_sg.security_group_id
}

output "app_security_group_id" {
  description = "Application Security Group ID"
  value       = module.app_sg.security_group_id
}

output "redis_sg_id" {
  value = module.redis_sg.security_group_id
}

output "efs_sg_id" {
  value = module.efs_sg.security_group_id
}