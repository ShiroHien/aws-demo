variable "project" {
  type = string
}

variable "vpc" {
  type = any
}

variable "sg" {
  type = any
}

variable "public_subnets" {}

variable "web_instance" {}

variable "lb_tg_name" {}
