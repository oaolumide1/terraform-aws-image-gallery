variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_ids" {
  type = list(string)
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