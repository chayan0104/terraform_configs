/*resource "random_pet" "rand_pet" {
  length = 2
}*/

#public ec2
resource "aws_instance" "my_ec2" {
  ami = "ami-019715e0d74f695be"
  instance_type = "t2.micro"
  region = var.region
  availability_zone = "ap-south-1a"
  
  tags ={
    Name = "instance-${var.service_name}"
  }
}

output "instance_details" {
  value = {
    instance_name = aws_instance.my_ec2.tags["Name"]
    instance_ip   = aws_instance.my_ec2.public_ip
  }
}