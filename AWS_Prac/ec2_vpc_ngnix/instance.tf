#public instance-------------------------------------------------------
resource "aws_instance" "public_instance" {
  #count = 2
  #count = length(var.ec2_conf_list)
  #ami = var.ec2_conf_list[count.index].ami
  #instance_type = var.ec2_conf_list[count.index].instance_type

  for_each = var.ec2_conf_map    # will get each.key and each.value
  ami = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = aws_subnet.public_subnet.id
  #availability_zone = "${var.region}a"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name = var.key_pair_name
  user_data = file("${path.module}/ngnix.sh")

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = merge(local.common_tags,{Name = "public_instance_${local.name}_${each.key}"})
}


#private instance------------------------------------------------------
/*
resource "aws_instance" "private_instance" {
  subnet_id = aws_subnet.private_subnet.id
  ami = var.ami_id
  #availability_zone = "${var.region}a"
  #associate_public_ip_address = true
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name = var.key_pair_name
  #user_data = file("${path.module}/ngnix.sh")

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = merge(local.common_tags,{Name = "private_instance_${local.name}"}) 
}
*/