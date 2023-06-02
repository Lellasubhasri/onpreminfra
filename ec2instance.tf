resource "aws_instance" "app_server" {
  
  #ami           = var.ami_for_app
  ami = "ami-0136ddddd07f0584f"
  instance_type = "t2.micro"
  #vpc_security_group_ids = [aws_security_group.appserver.id]
  key_name = "talent-academy-lab"
  #subnet_id = module.vpc.public_subnets[0]

  user_data = templatefile("${path.module}/app_user_data.sh.tpl", {
    db_private_ip = aws_instance.data_server.private_ip
    mysql_root_password = var.mysql_root_password
  })
  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index = 0
  }


  tags = {
    Name = "appserver"
  }
}

resource "aws_network_interface" "interface" {
  subnet_id        = module.vpc.public_subnets[0]
  security_groups  = [aws_security_group.appserver.id]
  tags = {
    Name = "interface"
  }
} 

resource "aws_instance" "data_server" {
  #ami           = var.ami_for_app
  ami = "ami-0136ddddd07f0584f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dbserver.id]
  key_name = "talent-academy-lab"
  subnet_id = module.vpc.private_subnets[0]
  #user_data = "${file(db_user_data.sh.tpl)}"
  user_data = templatefile("${path.module}/db_user_data.sh.tpl", {
    app_private_ip = aws_network_interface.interface.private_ip
    mysql_root_password = var.mysql_root_password
  })
  
  tags = {
    Name = "dataserver"
  }
}
