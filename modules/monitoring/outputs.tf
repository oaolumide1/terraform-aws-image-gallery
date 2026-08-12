output "sns_topic_arn" {
  description = "SNS Topic ARN"
  value       = aws_sns_topic.alerts.arn
}


output "alb_healthy_host_alarm" {
  description = "ALB Healthy Host Alarm"
  value       = aws_cloudwatch_metric_alarm.alb_healthy_hosts.alarm_name
}
output "alb_5xx_alarm" {
  description = "ALB HTTP 5XX Alarm"
  value       = aws_cloudwatch_metric_alarm.alb_5xx_errors.alarm_name
}
output "dashboard_name" {
  description = "CloudWatch Dashboard"

  value = aws_cloudwatch_dashboard.main.dashboard_name
}
