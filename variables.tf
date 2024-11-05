variable "env" {
  description = "environment variable"
  type = string
}

variable "aws_region" {
  description = "aws region"
  type = string
}

# vpc var
variable "vpc_name" {
  description = "name of the vpc"
  type = string
}

variable "cidr" {
  description = "CIDR block"
  type = string
}

variable "azs" {
  description = "avaibality zones"
  type = list(string)
}

variable "private_subnets" {
  description = "private subnets"
  type = list(string)
}

variable "public_subnets" {
  description = "public subnets"
  type = list(string)
}

variable "enable_nat_gateway" {
  description = "enable NAT Gateway"
  type = bool
}

variable "enable_vpn_gateway" {
  description = "enable_vpn_gateway"
  type = bool
}

# ec2 var
variable "instance_name" {
  description = "Name of the instance"
  type = string
}

variable "instance_type" {
  description = "Instance type"
  type = string
}

variable "ami_id" {
  description = "AMI ID of the instance"
  type = string
}

variable "key_name" {
  description = "key name of the instance"
  type = string
}

# rds var

variable "engine" {
  description = "engine database"
  type = string
}

variable "engine_version" {
  description = "engine version database"
  type = string
}
variable "family" {
  description = "family engine database"
  type = string
}

variable "instance_class" {
  description = "database instance class"
  type = string
}

variable "allocated_storage" {
  description = "allocating storage for instance"
  type = number
}

variable "rds_name" {
  description = "rds name instance"
  type = string
}

variable "db_name" {
  description = "database name"
  type = string
}

variable "username" {
  description = "username database"
  type = string
}

variable "password" {
  description = "password database"
  type = string
}

variable "port_db" {
  description = "port database"
  type = string
}