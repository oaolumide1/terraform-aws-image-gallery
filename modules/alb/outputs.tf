output "alb_dns_name" {
  value = module.alb.dns_name
}

output "target_group_arn" {
  value = module.alb.target_groups["app"].arn
}

output "alb_arn" {
  value = module.alb.arn
}