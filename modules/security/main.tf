module "alb_sg" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3"

  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Security Group for Application Load Balancer"

  vpc_id = var.vpc_id

 ingress_rules = [
  "http-80-tcp",
  "https-443-tcp"
]

ingress_cidr_blocks = [
  "0.0.0.0/0"
]

  egress_rules = [
    "all-all"
  ]
}

module "app_sg" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3"

  name        = "${var.project_name}-${var.environment}-app-sg"
  description = "Application Server Security Group"

  vpc_id = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]

  egress_rules = [
    "all-all"
  ]
}
module "redis_sg" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3"

  name        = "${var.project_name}-${var.environment}-redis-sg"
  description = "Redis Security Group"

  vpc_id = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 6379
      to_port                  = 6379
      protocol                 = "tcp"
      source_security_group_id = module.app_sg.security_group_id
    }
  ]

  egress_rules = [
    "all-all"
  ]
}
module "efs_sg" {

  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3"

  name        = "${var.project_name}-${var.environment}-efs-sg"
  description = "Amazon EFS Security Group"

  vpc_id = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 2049
      to_port                  = 2049
      protocol                 = "tcp"
      source_security_group_id = module.app_sg.security_group_id
    }
  ]

  egress_rules = [
    "all-all"
  ]
}