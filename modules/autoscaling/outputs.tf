output "launch_template_id" {

  value = aws_launch_template.app.id

}

output "launch_template_latest_version" {

  value = aws_launch_template.app.latest_version

}
output "autoscaling_group_name" {

  description = "Auto Scaling Group Name"

  value = aws_autoscaling_group.app.name

}

output "autoscaling_group_arn" {

  description = "Auto Scaling Group ARN"

  value = aws_autoscaling_group.app.arn

}