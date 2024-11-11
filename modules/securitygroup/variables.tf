variable "vpc" {
  type = any
}

variable "bastion_cidr_blocks" {
  type = list(string)
}
