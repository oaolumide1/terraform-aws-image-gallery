resource "aws_efs_file_system" "this" {
  creation_token = "${var.project_name}-${var.environment}-efs"

  encrypted = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-efs"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_efs_mount_target" "this" {
  count = length(var.private_subnets)

  file_system_id = aws_efs_file_system.this.id
  subnet_id      = var.private_subnets[count.index]

  security_groups = [
    var.efs_security_group_id
  ]
}