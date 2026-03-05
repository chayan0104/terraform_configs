terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "aws_ec2_vpc_ngnix/terraform.tfstate"
    region = "ap-south-1"
  }
}