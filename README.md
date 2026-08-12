# 🚀 AWS Image Gallery Infrastructure with Terraform

Production-ready AWS Infrastructure as Code (IaC) project built with Terraform, featuring modular architecture, remote state management, monitoring, alerting, and continuous integration.

![Terraform](https://img.shields.io/badge/Terraform-v1.5+-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazonaws)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-blue?logo=githubactions)
![Infrastructure as Code](https://img.shields.io/badge/Infrastructure-as-Code-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📖 Overview

This project demonstrates a **production-style Infrastructure as Code (IaC)** deployment on AWS using **Terraform**.

The infrastructure provisions a secure, scalable, and highly available environment following AWS best practices.

Instead of deploying standalone EC2 instances, the application runs behind an **Application Load Balancer (ALB)** using an **Auto Scaling Group**, making the environment resilient and capable of handling changing workloads.

---

## 🏗 Architecture

```
                        Internet
                            │
                            ▼
                 Application Load Balancer
                            │
              ┌─────────────┴─────────────┐
              ▼                           ▼
       EC2 Instance                 EC2 Instance
      (Auto Scaling)              (Auto Scaling)
              │                           │
              └─────────────┬─────────────┘
                            │
                        Amazon EFS

                 CloudWatch Dashboard
                         │
                         ▼
                 SNS Email Notifications

Terraform
     │
     ▼
Remote State (Amazon S3)

AWS Systems Manager
(Session Manager)
```

---

# 🚀 Features

- Modular Terraform architecture
- Remote Terraform state
- Amazon VPC
- Public & Private Subnets
- NAT Gateway
- Internet Gateway
- Application Load Balancer
- Launch Template
- Auto Scaling Group
- Amazon EFS
- Amazon S3
- IAM Roles & Instance Profiles
- AWS Systems Manager Session Manager
- CloudWatch Dashboard
- CloudWatch Alarms
- SNS Email Notifications
- GitHub Actions CI

---

# ☁ AWS Services Used

- Amazon VPC
- Amazon EC2
- Auto Scaling
- Elastic Load Balancer
- Amazon EFS
- Amazon S3
- IAM
- AWS Systems Manager
- Amazon CloudWatch
- Amazon SNS

---

# 📂 Project Structure

```
terraform-image-gallery/

├── .github/
│   └── workflows/
│
├── modules/
│   ├── alb/
│   ├── autoscaling/
│   ├── efs/
│   ├── iam/
│   ├── monitoring/
│   ├── network/
│   ├── s3/
│   └── security/
│
├── userdata/
│   └── userdata.sh
│
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── variables.tf
└── README.md
```

---

## Architecture Highlights

- High Availability across two Availability Zones
- Private EC2 instances managed through AWS Systems Manager
- Application Load Balancer for traffic distribution
- Auto Scaling Group with Launch Template
- Shared storage using Amazon EFS
- CloudWatch monitoring and alerting
- Remote Terraform state stored in Amazon S3

---

## Skills Demonstrated

- Terraform
- Infrastructure as Code (IaC)
- AWS Networking
- Amazon EC2
- Auto Scaling
- Elastic Load Balancing
- IAM
- CloudWatch
- SNS
- EFS
- S3
- Session Manager
- Git
- GitHub Actions
---

# 🚀 Deployment

Clone the repository

```bash
git clone https://github.com/oaolumide1/terraform-aws-image-gallery.git

cd terraform-aws-image-gallery
```

Initialize Terraform

```bash
terraform init
```

Validate

```bash
terraform validate
```

Review the execution plan

```bash
terraform plan
```

Deploy

```bash
terraform apply
```

Destroy

```bash
terraform destroy
```

---

# 📊 Monitoring

CloudWatch Dashboard includes:

- Application Load Balancer Healthy Hosts
- Application Load Balancer Request Count
- Auto Scaling Group Monitoring

CloudWatch Alarms

- ALB Healthy Host Count
- ALB HTTP 5XX Errors

Notifications

- Amazon SNS Email Alerts

---

# 🔒 Security

- Private EC2 Instances
- AWS Systems Manager Session Manager (no SSH required)
- IAM Roles
- Least Privilege Permissions
- Security Groups
- Encrypted EFS
- S3 Server-Side Encryption

---

# 📸 Screenshots

Create a **screenshots/** folder and include images such as:

```
screenshots/

architecture.png
autoscaling-group.png
alb.png
target-group.png
cloudwatch-dashboard.png
session-manager.png
terraform-plan-clean.png
```

---

# 🎯 Learning Outcomes

This project demonstrates practical experience with:

- Infrastructure as Code (Terraform)
- AWS Networking
- High Availability Architecture
- Auto Scaling
- Application Load Balancing
- IAM
- Monitoring & Alerting
- Cloud Operations
- Infrastructure Automation
- Production Infrastructure Design

---

# 🚀 Future Improvements

- HTTPS using AWS Certificate Manager (ACM)
- Route 53 custom domain
- AWS WAF
- Blue/Green Deployments
- CloudWatch Logs
- ElastiCache Redis
- CI/CD Pipeline Enhancements

---
# Version 2.0.0

## Highlights

- Migrated from standalone EC2 instances to an Auto Scaling Group
- Added Launch Template
- Implemented AWS Systems Manager Session Manager
- Added CloudWatch Dashboard
- Added CloudWatch Alarms
- Added SNS Notifications
- Modularized infrastructure
- Production-ready Terraform architecture
- Improved security posture
---
## Project Status

✔ Completed

Production-ready Terraform deployment demonstrating AWS infrastructure automation, Auto Scaling, monitoring, and Infrastructure as Code best practices.

---
# 👤 Author

**Oluwashola Olumide**

Cloud | DevOps | Infrastructure Engineer

GitHub:

https://github.com/oaolumide1

---

