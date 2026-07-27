module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr     
  environment  = var.environment
  my_public_ip = var.my_public_ip
}
module "rds" {
  source               = "./modules/rds"
  environment          = var.environment
  subnet_ids           = module.vpc.public_subnet_ids
  db_security_group_id = module.vpc.db_security_group_id
  db_password          = var.db_password
}
module "compute" {
  source                    = "./modules/compute"
  public_subnet_id          = module.vpc.public_subnet_id
  compute_security_group_id = module.vpc.compute_security_group_id
  key_name                  = "taskapp-key"
  environment               = var.environment
}
