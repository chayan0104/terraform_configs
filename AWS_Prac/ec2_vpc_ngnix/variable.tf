variable "region" {
  type        = string
  default     = "ap-south-1"
}

locals {
  common_tags = {
    team = "devops"
    user = "chayan"
  }
  name = "back_panther"
}

variable "ec2_conf_list" {
  type = list(object({
    ami = string
    instance_type = string
  }))
}

variable "ec2_conf_map" {
  #key =value{ object(ami,instance)}
  type = map(object({
    ami = string
    instance_type = string
  })) 
}

/*
variable "instance_type" {
  type    = string
  default = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Instance type must be t2.micro or t3.micro."
  }
}
*/

variable "key_pair_name" {
  type        = string
  default     = null
  nullable    = true
}

/*
variable "default_tags" {
  type        = map(string)
  default     = {
       "team" = "devops"
       "user" = "chayan"
  }
}

variable "default_name" {
  type        = string
  default = "white_tiger"
  
}
*/
