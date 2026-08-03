#################################
# Network Module
#################################

module "network" {
  source = "./modules/network"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
module "security" {
  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id
}
module "efs" {
  source = "./modules/efs"

  project_name = var.project_name
  environment  = var.environment

  private_subnets       = module.network.private_subnets
  efs_security_group_id = module.security.efs_sg_id
}
module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment

  bucket_name = var.bucket_name
  bucket_arn  = module.s3.bucket_arn
}
module "s3" {

  source = "./modules/s3"

  project_name = var.project_name
  environment  = var.environment

  bucket_name = var.bucket_name
}
module "alb" {
  source = "./modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id

  public_subnets = module.network.public_subnets

  alb_security_group_id = module.security.alb_sg_id
}
#################################
# EC2 Module
#################################

module "ec2" {
  source = "./modules/ec2"

  project_name = var.project_name
  environment  = var.environment

  instance_count = var.instance_count
  instance_type  = var.instance_type
  key_pair_name  = var.key_pair_name

  private_subnets       = module.network.private_subnets
  app_security_group_id = module.security.app_sg_id

  instance_profile_name = module.iam.instance_profile_name

  target_group_arn = module.alb.target_group_arn

  efs_dns_name = module.efs.efs_dns_name
}