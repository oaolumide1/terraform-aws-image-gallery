#################################
# Local Values
#################################

locals {
  alb_arn_suffix = join(
    "/",
    slice(split("/", var.alb_arn), 1, length(split("/", var.alb_arn)))
  )

  target_group_arn_suffix = regex(
    "targetgroup/.+$",
    var.target_group_arn
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


#################################
# EC2 Status Check Alarm
#################################


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
          title  = "ALB Healthy Hosts"
          view   = "timeSeries"
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

          stat   = "Average"
          period = 60
        }
      },

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {
          title  = "Auto Scaling Group Average CPU"
          view   = "timeSeries"
          region = "ca-central-1"

          metrics = [
            [
              "AWS/AutoScaling",
              "GroupInServiceInstances",
              "AutoScalingGroupName",
              var.autoscaling_group_name
            ]
          ]

          stat   = "Average"
          period = 300
        }
      },
      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {

          title = "ALB Request Count"

          view = "timeSeries"

          region = "ca-central-1"

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              local.alb_arn_suffix
            ]
          ]

          stat   = "Sum"
          period = 60
        }
      }

    ]

  })
}



