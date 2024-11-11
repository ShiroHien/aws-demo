variable "vpc" {
  type = any
}

variable "sg" {
  type = any
}

variable "database_subnets" {}

variable "db_allocated_storage" {}

variable "db_engine" {}

variable "db_engine_version" {}

variable "db_instance_class" {}

variable "db_name" {}

variable "db_subnet_group_name" {}
