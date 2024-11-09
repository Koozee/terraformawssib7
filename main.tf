# deploy vpc
module "wp-vpc" {
  
  source = "./modules/wp-vpc"
  env = var.env
  vpc_name = var.vpc_name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
}

# deploy rds
module "wp-rds" {
  
  source = "./modules/wp-rds"
  env = var.env
  rds_name = var.rds_name

  engine            = var.engine
  engine_version    = var.engine_version
  family = var.family
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.username
  password = var.password
  port_db  = var.port_db

  vpc_security_group_ids = [module.wp-vpc.rds_security_group_ids[0]]
  subnetrds_id = [module.wp-vpc.private_subnet_ids[0], module.wp-vpc.private_subnet_ids[1]]
  rds_group_name = module.wp-vpc.db_subnet_group_name_ids
}

# deploy ec2
module "wp-instances" {
  
  source = "./modules/wp-instances"
  env = var.env
  instance_name = var.instance_name

  ami_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name

  vpc_security_group_ids = [module.wp-vpc.wordpress_security_group_ids[0]]
  subnet_id = module.wp-vpc.public_subnet2_id
}

resource "aws_s3_bucket" "remote_state" {
  bucket        = "seal-remote-state"
  force_destroy = true
  tags = {
    Name        = "seal-remote-state"
    Environment = var.env
  }
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "SealRemoteState"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }

  tags = {
    Name        = "seal-remote-state"
    Environment = var.env
  }
}