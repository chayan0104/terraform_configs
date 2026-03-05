#vpc----------------------------------------------
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
      Name = "my_vpc-${var.service_name}"
    }
}

#public_subnet----------------------------------------
resource "aws_subnet" "public_subnet" {
    vpc_id =aws_vpc.my_vpc.id
    cidr_block = var.public_sub_cidr
    availability_zone = "${var.region}a"
    #availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true


    tags = {
      Name = "my_public_subnet-${var.service_name}"
    } 
}

#Internet Gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "my_internet_gateway-${var.service_name}"
    }
}
#route table
resource "aws_route_table" "my_public_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
        
    }
    tags = {
      Name = "public_route_table-${var.service_name}"
    }
}
/*
#route association
resource "aws_route_table_association" "my_public_rta_public" {
    route_table_id = aws_route_table.my_public_rt.id
    subnet_id      = aws_subnet.public_subnet.id
}
*/
resource "aws_main_route_table_association" "main_rt" {
  vpc_id         = aws_vpc.my_vpc.id
  route_table_id = aws_route_table.my_public_rt.id
}

#private_subnet----------------------------------------
resource "aws_subnet" "private_subnet" {
    vpc_id =aws_vpc.my_vpc.id
    cidr_block = var.private_sub_cidr
    availability_zone = "${var.region}b"

    tags = {
      Name = "my_private_subnet-${var.service_name}"
    } 
}
#elastic IP
resource "aws_eip" "my_elasticip" {
    domain = "vpc"

    tags = {
     Name = "nat-eip-${var.service_name}"
  }
}

#Nat gateway
resource "aws_nat_gateway" "my_nat" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.my_elasticip.id
    
    depends_on = [ aws_internet_gateway.my_igw ]
    tags = {
      Name = "my_nat-${var.service_name}"
    }
}

#route table
resource "aws_route_table" "my_private_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.my_nat.id
    }
    tags = {
      Name = "private_route_table-${var.service_name}"
    }
}

#route association
resource "aws_route_table_association" "my_private_rta_public" {
    route_table_id = aws_route_table.my_private_rt.id
    subnet_id      = aws_subnet.private_subnet.id
}