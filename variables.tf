#################################
# Project Variables
#################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

#################################
# AWS Variables
#################################

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

#################################
# Network Variables
#################################

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

#################################
# EC2 Variables
#################################

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "key_pair_name" {
  description = "AWS Key Pair Name"
  type        = string
}
variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

#################################
# S3 Variables
#################################

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

#################################
# Monitoring Variables
#################################

variable "alarm_email" {
  description = "SNS Email for CloudWatch Alerts"
  type        = string
}