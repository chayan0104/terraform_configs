terraform {
  backend "s3" {
    bucket = "cs-terraform-configs"
    key    = "ec2_conf/backend.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}