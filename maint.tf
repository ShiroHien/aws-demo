locals {
  project = var.project
}

provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"

  vpc_cidr            = var.vpc_cidr
  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets
  availability_zone   = var.availability_zone
  vpc_name            = var.vpc_name
  public_subnet_name  = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
}

module "securitygroup" {
  source = "./modules/securitygroup"

  vpc                 = module.networking.vpc
  bastion_cidr_blocks = var.bastion_cidr_blocks
}

module "database" {
  source = "./modules/database"

  vpc                  = module.networking.vpc
  sg                   = module.securitygroup.sg
  database_subnets     = [module.networking.private_subnets_ids[0], module.networking.private_subnets_ids[1]]
  db_allocated_storage = var.db_allocated_storage
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_name              = var.db_name
  db_subnet_group_name = var.db_subnet_group_name
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  project        = local.project
  vpc            = module.networking.vpc
  sg             = module.securitygroup.sg
  public_subnets = module.networking.public_subnet_ids
  web_instance   = module.web_server.instance_id
  lb_tg_name     = var.lb_tg_name
}

module "bastion" {
  source = "./modules/instance"

  vpc                  = module.networking.vpc
  sg                   = module.securitygroup.sg.bastion
  subnet               = module.networking.public_subnet_ids[0]
  ami_filter_value     = var.ami_filter_value
  ami_owners           = var.ami_owners
  key_name             = var.bastion_key_name
  server_name          = var.bastion_server
  server_instance_type = var.server_instance_type
}

module "web_server" {
  source = "./modules/instance"

  vpc                  = module.networking.vpc
  sg                   = module.securitygroup.sg.web
  ami_filter_value     = var.ami_filter_value
  ami_owners           = var.ami_owners
  subnet               = module.networking.private_subnets_ids[0]
  key_name             = var.web_key_name
  server_name          = var.web_server
  server_instance_type = var.server_instance_type
}
