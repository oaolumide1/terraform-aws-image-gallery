#################################
# Project
#################################

project_name = "image-gallery"
environment  = "dev"

#################################
# AWS
#################################

aws_region = "ca-central-1"

#################################
# Network
#################################

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "ca-central-1a",
  "ca-central-1b"
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.101.0/24",
  "10.0.102.0/24"
]

#################################
# EC2
#################################

instance_type  = "t3.micro"
instance_count = 2
key_pair_name  = "webkey"

#################################
# S3
#################################

bucket_name = "oaolumide1-image-gallery-738882406911"