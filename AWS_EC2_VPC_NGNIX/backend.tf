terraform {
  backend "s3" {
    bucket = "cs-terraform-configs"
    key    = "aws_ec2_vpc_ngnix/backend.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}