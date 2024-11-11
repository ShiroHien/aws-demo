resource "random_password" "rds_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "database" {
    allocated_storage      = var.db_allocated_storage
    engine                 = var.db_engine
    engine_version         = var.db_engine_version
    instance_class         = var.db_instance_class
    db_name                = var.db_name
    username               = "admin"
    password               = random_password.rds_password.result
    vpc_security_group_ids = [var.sg.db]
    db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
    skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = var.database_subnets

  tags = {
    Name = var.db_subnet_group_name
  }
}
