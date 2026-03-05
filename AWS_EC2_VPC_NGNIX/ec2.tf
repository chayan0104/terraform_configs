#public_Ec2----------------------------------------
resource "aws_instance" "nginx_server" {
  subnet_id                   = aws_subnet.public_subnet.id
  ami                         = "ami-019715e0d74f695be"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  key_name                    = "Devops-key-main"

  user_data = file("./nginx.sh")

  tags = {
    Name = "nginx-server-${var.service_name}"
  }
}

#public security group
resource "aws_security_group" "public_sg" {
    vpc_id = aws_vpc.my_vpc.id

    ingress {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ingress {
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ingress {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "public_sg-${var.service_name}"
  }
  
}

#private Ec2-------------------------------------------------------
/*
resource "aws_instance" "private_ec2" {
  subnet_id                   = aws_subnet.private_subnet.id
  ami                         = "ami-019715e0d74f695be"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  key_name                    = "Devops-key-main"

  tags = {
    Name = "private_ec2-${var.service_name}"
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg-${var.service_name}"
  }
}
*/