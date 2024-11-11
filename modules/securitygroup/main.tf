module "alb_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = var.vpc.id
  ingress_rules = [
    {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "bastion_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = var.vpc.id
  description = "Allow SSH inbound connections"

  ingress_rules = [
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = var.bastion_cidr_blocks
    }
  ]
}

module "web_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = var.vpc.id
  ingress_rules = [
    {
      port        = 80
      security_groups = [module.alb_sg.security_group.id]
    },
    {
      port        = 22
      protocol    = "tcp"
      security_groups = [module.bastion_sg.security_group.id]
    }
  ]
}

module "db_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = var.vpc.id
  ingress_rules = [
    {
      port            = 5432
      security_groups = [module.web_sg.security_group.id]
    }
  ]
}
