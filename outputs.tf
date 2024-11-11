output "db_password" {
  value     = module.database.config.password
  sensitive = true
}

output "lb_dns_name" {
  value = module.loadbalancer.lb_dns
}

output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "web_private_ip" {
  value = module.web_server.private_ip
}
