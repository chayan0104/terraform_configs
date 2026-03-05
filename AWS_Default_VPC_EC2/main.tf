data "aws_vpc" "default" {
  default = true
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_default_subnet" "selected" {
  availability_zone = var.availability_zone
}

resource "aws_security_group" "nginx_sg" {
  name_prefix = "${var.service_name}-nginx-sg-"
  description = "Allow SSH and HTTP access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ingress_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ingress_cidr]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.service_name}-nginx-sg"
  }
}

resource "aws_instance" "nginx_server" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = aws_default_subnet.selected.id
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    yum update -y
    amazon-linux-extras enable nginx1 || true
    yum clean metadata
    yum install -y nginx

    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!doctype html>
    <html>
      <head>
        <meta charset="UTF-8">
        <title>Terraform Nginx</title>
      </head>
      <body>
        <h1>Nginx from Terraform</h1>
        <p>Region: ap-south-1</p>
        <p>Instance Type: t2.micro</p>
      </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
  EOF

  tags = {
    Name = "${var.service_name}-nginx-ec2"
  }
}
