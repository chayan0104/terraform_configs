#terraform apply -var-file="dev.tfvars"
#using list
ec2_conf_list = [ {
  ami = "ami-019715e0d74f695be" #ubuntu
  instance_type = "t2.micro"
},
{
  ami = "ami-0ffef61f6dc37ae89" #rhel
  instance_type = "t2.micro"
}
]

#using map
ec2_conf_map = {
  "ubuntu" = {
    ami = "ami-019715e0d74f695be"
    instance_type = "t3.micro"
  },
  "rhel" = {
    ami = "ami-0ffef61f6dc37ae89"
    instance_type = "t3.micro"
  }
}