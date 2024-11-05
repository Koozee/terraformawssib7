variable "env" {
    description = "environment variable"
    type = string
}

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

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "subnetrds_id" {
  type = list(string)
}

variable "rds_group_name" {
  type = string
}