output "rds_security_group_ids" {
  value = [aws_security_group.rds_security_group.id]
}

output "wordpress_security_group_ids" {
  value = [aws_security_group.wordpress-sg.id]
}

output "public_subnet2_id" {
  value = module.wp-vpc.public_subnets[1]
}

output "private_subnet_ids" {
  value       = [module.wp-vpc.private_subnets[0], module.wp-vpc.private_subnets[1]]
}

output "db_subnet_group_name_ids" {
  value = aws_db_subnet_group.rds_subnet_group.id
}
