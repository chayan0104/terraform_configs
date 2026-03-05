#public access-------------------------------------------------------
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = merge(local.common_tags,{Name = "igw_${local.name}"}) 
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  
  tags = merge(local.common_tags,{Name = "public_rt_${local.name}"}) 
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "public_route_association" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_subnet.id
}

#private access--------------------------------------------------------
/*
resource "aws_eip" "elastic_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.elastic_ip.id
  vpc_id = aws_vpc.my_vpc.id
  depends_on = [ aws_internet_gateway.my_igw ]

  tags = merge(local.common_tags,{Name = "nat_${local.name}"})
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = merge(
  local.common_tags,{Name = "private_rt_${local.name}"})
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.my_nat.id  
}

resource "aws_route_table_association" "private_route_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private_subnet.id
}
*/