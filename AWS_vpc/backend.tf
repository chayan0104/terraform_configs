terraform {
  backend "s3" {
    bucket = "cs-terraform-configs"
    key    = "vpc_conf/backend.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}