module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name = "${var.project_name}-${var.environment}-alb"

  load_balancer_type = "application"

  create_security_group = false

  vpc_id  = var.vpc_id
  subnets = var.public_subnets

  security_groups = [
    var.alb_security_group_id
  ]

  enable_deletion_protection = false

  target_groups = {
    app = {
      name_prefix = "app"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"

      create_attachment = false

      health_check = {
        enabled             = true
        path                = "/"
        matcher             = "200"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
      }
    }
  }

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "app"
      }
    }
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}