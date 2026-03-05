variable "region" {
  type        = string
  description = "AWS region where resources will be created."
  default     = "ap-south-1"
}

variable "service_name" {
  type        = string
  description = "Name prefix for resources."
  default     = "nginx-default-vpc"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone used for the default subnet."
  default     = "ap-south-1a"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name in AWS."
  default     = "Devops-key-main"
}

variable "allowed_ingress_cidr" {
  type        = string
  description = "CIDR allowed to access SSH and HTTP."
  default     = "0.0.0.0/0"
}

variable "common_tags" {
  type = map(string)
  default = {
    Project = "terraform-lab"
    Managed = "terraform"
    Service = "nginx"
  }
}
