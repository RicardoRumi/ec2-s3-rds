provider "aws" {
  region  = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  environment   = var.environment
  vpc_cidr      = var.vpc_cidr
  public_cidrs  = var.public_subnet_cidrs
  private_cidrs = var.private_subnet_cidrs
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
}

module "ec2" {
  source = "./modules/ec2"

  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_ids[0]
  your_ip          = var.your_ip
  bucket_name      = module.s3.bucket_name
}

module "rds" {
  source = "./modules/rds"

  environment            = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  ec2_security_group_id = module.ec2.security_group_id

  instance_class     = var.rds_instance_class
  database_name      = var.database_name
  database_username  = var.database_username
  database_password  = var.database_password
} 