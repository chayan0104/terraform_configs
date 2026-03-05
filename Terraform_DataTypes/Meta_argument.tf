provider "aws" {
    region = "ap-suth-1"
}
############COUNT###########################
#index
variable "bucket_names" {
   type = list(string)
   default = [ "sample1","sample2" ]
}
resource "aws_s3_bucket" "my_bucket" {
    count = length(var.bucket_names)
    bucket = var.bucket_names[count.index]
    tags = {
      env = var.bucket_names[count.index]
    }
}
#############For_EACH########################
#map
variable "bucket_name_map" {
    type = map(string)
    default = {
      "dev" = "dev_bucket"
      "prod" = "prod_bucket"
    } 
}
resource "aws_s3_bucket" "my_bucket" {
    for_each = var.bucket_name_map
    bucket = each.value
    tags = {
      env = each.key
    }
}
#set
variable "bucket_name_set" {
    type = set(string)
    default = [ "dev_bucket","prod_bucket" ]
}
resource "aws_s3_bucket" "my_bucket" {
    for_each = var.bucket_name_set
    bucket = each.value
    tags = {
      env = each.value
    } 
}