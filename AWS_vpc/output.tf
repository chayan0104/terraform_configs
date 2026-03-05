output "network_details" {
  description = "All network resource IDs"
  value = {
    vpc_id            = aws_vpc.my_vpc.id
    public_subnet_id  = aws_subnet.public_subnet.id
    private_subnet_id = aws_subnet.private_subnet.id
    igw_id            = aws_internet_gateway.my_igw.id
    nat_id            = aws_nat_gateway.my_nat.id
  }
}