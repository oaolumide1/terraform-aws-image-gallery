variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}
variable "bucket_arn" {
  description = "ARN of the S3 bucket"
  type        = string
}