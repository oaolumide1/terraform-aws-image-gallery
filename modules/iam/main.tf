data "aws_iam_policy_document" "ec2_assume_role" {

  statement {

    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}
resource "aws_iam_role" "ec2_role" {

  name = "${var.project_name}-${var.environment}-ec2-role"

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}
resource "aws_iam_role_policy_attachment" "cloudwatch" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
resource "aws_iam_instance_profile" "ec2_profile" {

  name = "${var.project_name}-${var.environment}-instance-profile"

  role = aws_iam_role.ec2_role.name
}
data "aws_iam_policy_document" "s3_access" {

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${var.bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      var.bucket_arn
    ]
  }
}
resource "aws_iam_policy" "s3_policy" {

  name = "${var.project_name}-${var.environment}-s3-policy"

  policy = data.aws_iam_policy_document.s3_access.json
}
resource "aws_iam_role_policy_attachment" "s3_policy" {

  role = aws_iam_role.ec2_role.name

  policy_arn = aws_iam_policy.s3_policy.arn
}