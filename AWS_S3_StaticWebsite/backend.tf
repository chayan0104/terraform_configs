terraform {
  backend "s3" {
    bucket  = "cs-terraform-configs"
    key     = "s3_conf/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}