variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}


variable "alb_arn" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "notification_email" {
  type = string
}
variable "autoscaling_group_name" {
  description = "Auto Scaling Group Name"
  type        = string
}