module "image_bucket" {

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.0"

  bucket = var.bucket_name

  force_destroy = true

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-bucket"
    Project     = var.project_name
    Environment = var.environment
  }
}