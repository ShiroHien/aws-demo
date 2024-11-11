data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = var.ami_filter_value
  }

  owners = var.ami_owners
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip-association" {
  instance_id = aws_instance.server.id
  allocation_id = aws_eip.eip.id
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "private-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.key_name
  file_permission = "0400"
}

resource "aws_network_interface" "interface" {
  subnet_id       = var.subnet
  security_groups = [var.sg]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ami.id
  instance_type = var.server_instance_type
  key_name      = aws_key_pair.key_pair.key_name

  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index         = 0
  }

  tags = {
    Name = var.server_name
  }
}
