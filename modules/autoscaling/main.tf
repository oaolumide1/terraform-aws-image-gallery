#################################
# Amazon Linux 2023
#################################

data "aws_ssm_parameter" "amazon_linux" {

  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"

}
#################################

# Launch Template
#################################

resource "aws_launch_template" "app" {

  name_prefix = "${var.project_name}-${var.environment}-"

  image_id = data.aws_ssm_parameter.amazon_linux.value

  instance_type = var.instance_type

  key_name = var.key_pair_name

  update_default_version = true

  iam_instance_profile {

    name = var.instance_profile_name

  }

  vpc_security_group_ids = [

    var.app_security_group_id

  ]

  user_data = base64encode(

    templatefile("${path.root}/userdata/userdata.sh", {

      efs_dns_name = var.efs_dns_name

      environment = var.environment

    })

  )

  monitoring {

    enabled = true

  }

  tag_specifications {

    resource_type = "instance"

    tags = {

      Name = "${var.project_name}-${var.environment}-app"

      Environment = var.environment

      Terraform = "true"

    }

  }

}
#################################
# Auto Scaling Group
#################################

resource "aws_autoscaling_group" "app" {

  name = "${var.project_name}-${var.environment}-asg"

  min_size = var.min_size

  desired_capacity = var.desired_capacity

  max_size = var.max_size

  health_check_type         = "ELB"
  health_check_grace_period = 300

  vpc_zone_identifier = var.private_subnets

  target_group_arns = [
    var.target_group_arn
  ]

  launch_template {

    id      = aws_launch_template.app.id
    version = "$Latest"

  }

  tag {

    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-app"
    propagate_at_launch = true

  }

  tag {

    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true

  }

  tag {

    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true

  }

}
#################################
# Target Tracking Scaling Policy
#################################

resource "aws_autoscaling_policy" "cpu_target_tracking" {

  name = "${var.project_name}-${var.environment}-cpu-target"

  autoscaling_group_name = aws_autoscaling_group.app.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {

    predefined_metric_specification {

      predefined_metric_type = "ASGAverageCPUUtilization"

    }

    target_value = 60

  }

}
#################################
# Auto Scaling Notifications
#################################

resource "aws_autoscaling_notification" "notifications" {

  group_names = [
    aws_autoscaling_group.app.name
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"
  ]

  topic_arn = var.sns_topic_arn
}