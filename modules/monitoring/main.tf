#################################
# Local Values
#################################

locals {
  alb_arn_suffix = join(
    "/",
    slice(split("/", var.alb_arn), 1, length(split("/", var.alb_arn)))
  )

  target_group_arn_suffix = join(
    "/",
    slice(split("/", var.target_group_arn), 1, length(split("/", var.target_group_arn)))
  )
}
#################################
# SNS Topic
#################################

resource "aws_sns_topic" "alerts" {

  name = "${var.project_name}-${var.environment}-alerts"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
#################################
# Email Subscription
#################################

resource "aws_sns_topic_subscription" "email" {

  topic_arn = aws_sns_topic.alerts.arn

  protocol = "email"

  endpoint = var.notification_email
}
#################################
# EC2 CPU Utilization Alarms
#################################

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {

  count = length(var.instance_ids)

  alarm_name          = "${var.project_name}-${var.environment}-ec2-${count.index + 1}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"

  period    = 300
  statistic = "Average"

  threshold = 80

  alarm_description = "Alarm when EC2 CPU exceeds 80%"

  dimensions = {
    InstanceId = var.instance_ids[count.index]
  }

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
#################################
# EC2 Status Check Alarm
#################################

resource "aws_cloudwatch_metric_alarm" "ec2_status" {

  count = length(var.instance_ids)

  alarm_name          = "${var.project_name}-${var.environment}-ec2-${count.index + 1}-status-check"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2

  metric_name = "StatusCheckFailed"

  namespace = "AWS/EC2"

  period = 60

  statistic = "Maximum"

  threshold = 0

  alarm_description = "EC2 Instance Status Check Failed"

  dimensions = {
    InstanceId = var.instance_ids[count.index]
  }

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
#################################
# ALB Healthy Host Alarm
#################################

resource "aws_cloudwatch_metric_alarm" "alb_healthy_hosts" {

  alarm_name        = "${var.project_name}-${var.environment}-alb-healthy-hosts"
  alarm_description = "Alarm when healthy targets fall below 2"

  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2

  metric_name = "HealthyHostCount"
  namespace   = "AWS/ApplicationELB"

  statistic = "Average"

  period = 60

  threshold = 2

  dimensions = {
    LoadBalancer = local.alb_arn_suffix
    TargetGroup  = local.target_group_arn_suffix
  }

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
#################################
# ALB HTTP 5XX Alarm
#################################

resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {

  alarm_name        = "${var.project_name}-${var.environment}-alb-5xx-errors"
  alarm_description = "Alarm when the ALB returns HTTP 5XX errors"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2

  metric_name = "HTTPCode_ELB_5XX_Count"
  namespace   = "AWS/ApplicationELB"

  statistic = "Sum"
  period    = 300

  threshold = 5

  dimensions = {
    LoadBalancer = local.alb_arn_suffix
  }

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
#################################
# CloudWatch Dashboard
#################################

resource "aws_cloudwatch_dashboard" "main" {

  dashboard_name = "${var.project_name}-${var.environment}-dashboard"

  dashboard_body = jsonencode({

    widgets = [

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {

          title = "EC2 CPU Utilization"

          view = "timeSeries"

          region = "ca-central-1"

          metrics = [
            for id in var.instance_ids : [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              id
            ]
          ]

          period = 300
          stat   = "Average"
        }
      },

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {

          title = "ALB Healthy Hosts"

          view = "timeSeries"

          region = "ca-central-1"

          metrics = [
            [
              "AWS/ApplicationELB",
              "HealthyHostCount",
              "LoadBalancer",
              local.alb_arn_suffix,
              "TargetGroup",
              local.target_group_arn_suffix
            ]
          ]

          stat = "Average"

          period = 60
        }
      }

    ]

  })
}