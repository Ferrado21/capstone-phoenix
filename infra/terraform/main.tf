module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}
module "rds" {
  source               = "./modules/rds"
  environment          = var.environment
  subnet_ids           = module.vpc.public_subnet_ids
  db_security_group_id = module.vpc.db_security_group_id
  db_password          = var.db_password
}
