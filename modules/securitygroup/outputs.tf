output "sg" {
  value = {
    alb     = module.alb_sg.security_group.id
    bastion = module.bastion_sg.security_group.id
    web     = module.web_sg.security_group.id
    db      = module.db_sg.security_group.id
  }
}
