variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Aws region to create resources"
}
variable "service_name" {
  default = "stoic_fox"
}
variable "common_tags" {
  type = map(string)

  default = {
    Team  = "devops"
    Owner = "chayan"
  }
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_sub_cidr" {
  default = "10.0.1.0/24"
}
variable "private_sub_cidr" {
  default = "10.0.2.0/24"
}