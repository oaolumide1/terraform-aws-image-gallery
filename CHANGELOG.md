# Changelog

All notable changes to this project are documented in this file.

## [1.0.0] - 2026-08-07

### Added

- Modular Terraform architecture
- Amazon VPC with public and private subnets
- Internet Gateway and NAT Gateway
- Route Tables and Security Groups
- Application Load Balancer (ALB)
- Amazon EC2 Auto-deployment with User Data
- Amazon EFS shared storage
- Amazon S3 bucket
- IAM Roles and Instance Profiles
- Dynamic Amazon Linux 2023 AMI lookup using AWS Systems Manager Parameter Store
- Reusable Terraform modules
- Architecture diagram
- Project documentation
- Deployment screenshots

### Fixed

- Resolved ALB Security Group conflicts
- Imported manually created Security Group rules into Terraform state
- Eliminated Terraform state drift
- Replaced hardcoded AMI with dynamic SSM lookup