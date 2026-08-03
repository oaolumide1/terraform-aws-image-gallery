#################################
# Project Information
#################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

#################################
# EC2 Configuration
#################################

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_pair_name" {
  description = "AWS Key Pair"
  type        = string
}

#################################
# Networking
#################################

variable "private_subnets" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "app_security_group_id" {
  description = "Application Security Group"
  type        = string
}

#################################
# IAM
#################################

variable "instance_profile_name" {
  description = "IAM Instance Profile"
  type        = string
}

#################################
# Load Balancer
#################################

variable "target_group_arn" {
  description = "ALB Target Group ARN"
  type        = string
}

#################################
# EFS
#################################

variable "efs_dns_name" {
  description = "EFS DNS Name"
  type        = string
}