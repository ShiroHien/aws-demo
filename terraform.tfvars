project = "terraform-series"
region  = "us-west-2"

vpc_cidr          = "10.0.0.0/16"
private_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone = ["us-west-2a", "us-west-2b"]

vpc_name            = "My VPC"
public_subnet_name  = "Public Subnet"
private_subnet_name = "Private Subnet"
bastion_cidr_blocks = ["113.160.19.218/32", "118.70.133.189/32", "27.72.56.167/32"]

bastion_key_name = "bastion_key"
bastion_server   = "Bastion Server"

web_key_name = "web_key"
web_server   = "Web Server"

db_allocated_storage = 10
db_engine            = "mysql"
db_engine_version    = "8.0"
db_instance_class    = "db.t3.micro"
db_name              = "mydb"
db_subnet_group_name = "My db subnet group"

ami_filter_value     = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
ami_owners           = ["099720109477"]
server_instance_type = "t2.micro"

lb_tg_name = "loadbalancer-tg"
