#vpc----------------------------------------------------------------
resource "aws_vpc" "my_vpc" {
  region = var.region
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags,{Name = "vpc_${local.name}"})
}

#public subnet-------------------------------------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = merge(local.common_tags,{Name = "public_subnet_${local.name}"})
}

#private subnet-------------------------------------------------------

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = false

  tags = merge(local.common_tags,{Name = "private_subnet_${local.name}"})
}
