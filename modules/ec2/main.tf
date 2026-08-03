#################################
# EC2 Instances
#################################

resource "aws_instance" "app" {
  count = var.instance_count

  ami                    = data.aws_ssm_parameter.amazon_linux.value
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = var.private_subnets[count.index]
  vpc_security_group_ids = [var.app_security_group_id]

  iam_instance_profile = var.instance_profile_name

  user_data = templatefile("${path.root}/userdata/userdata.sh", {
    efs_dns_name = var.efs_dns_name
    environment  = var.environment
  })

  associate_public_ip_address = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-app-${count.index + 1}"
    Environment = var.environment
    Terraform   = "true"
  }
}

#################################
# Target Group Attachments
#################################

resource "aws_lb_target_group_attachment" "app" {
  count = var.instance_count

  target_group_arn = var.target_group_arn
  target_id        = aws_instance.app[count.index].id
  port             = 80
}