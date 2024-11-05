module "wp-rds" {
  
  source = "terraform-aws-modules/rds/aws"
  identifier = var.rds_name

  engine             = var.engine              
  major_engine_version = var.engine_version       
  family             = var.family                 
  instance_class     = var.instance_class
  allocated_storage   = var.allocated_storage

  db_name            = var.db_name
  username           = var.username
  password           = var.password
  port               = var.port_db
  skip_final_snapshot = true

  db_subnet_group_name = var.rds_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_ids = var.subnetrds_id

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}
