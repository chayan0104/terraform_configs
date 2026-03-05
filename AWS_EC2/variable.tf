variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Aws region to create resources"
}

variable "service_name" {
  default = "white-tiger"
}

variable "common_tags" {
  type = map(string)

  default = {
    Team  = "devops"
    Owner = "chayan"
  }
}

