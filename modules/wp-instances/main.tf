module "wp-instances" {
  
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = var.instance_name

  ami = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  associate_public_ip_address = true
  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}