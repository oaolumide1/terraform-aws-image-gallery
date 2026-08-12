#################################
# Project

#################################

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

#################################
# EC2

#################################

variable "instance_type" {
  type = string
}

variable "key_pair_name" {
  type = string
}

#################################
# IAM

#################################

variable "instance_profile_name" {
  type = string
}

#################################
# Networking

#################################

variable "private_subnets" {
  type = list(string)
}

variable "app_security_group_id" {
  type = string
}

#################################
# ALB

#################################

variable "target_group_arn" {
  type = string
}

#################################
# EFS

#################################

variable "efs_dns_name" {
  type = string
}
variable "min_size" {
  description = "Minimum number of instances"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
  default     = 4
}
variable "sns_topic_arn" {
  description = "SNS topic for Auto Scaling notifications"
  type        = string
}