# Terraform Lab: EC2 + VPC + Nginx

Simple AWS lab for learning Terraform networking.

## What this project creates

1. One VPC (`10.0.0.0/16`)
2. One public subnet (`10.0.1.0/24`)
3. One private subnet (`10.0.2.0/24`)
4. Internet Gateway
5. NAT Gateway + Elastic IP
6. Public and private route tables
7. Public and private security groups
8. Public EC2 (runs Nginx via `user_data`)
9. Private EC2 (no public IP)

## Network flow

1. Internet -> Internet Gateway -> Public Subnet -> Public EC2
2. Private EC2 -> NAT Gateway -> Internet Gateway -> Internet
3. Internet cannot directly access Private EC2

## Files

1. `provide.tf`: Terraform + AWS provider config
2. `variable.tf`: all input variables
3. `vpcsubnet.tf`: VPC and subnets
4. `gateways.tf`: IGW, NAT, route tables, route associations
5. `securitygroup.tf`: public/private security groups
6. `instance.tf`: EC2 resources
7. `ngnix.sh`: startup script to install and run Nginx
8. `outputs.tf`: useful output values after apply

## How to run

1. Initialize:

```bash
terraform init
```

2. Optional: set values (for example key pair and SSH CIDR):

```bash
terraform plan -var="key_pair_name=your-key-name" -var="ssh_allowed_cidr=YOUR_IP/32"
```

3. Apply:

```bash
terraform apply
```

4. Open output `public_instance_url` in browser.

## Notes for learning

1. `backend.tf` is commented intentionally so you can start without S3 remote state.
2. NAT Gateway costs money; destroy resources when done.
3. If AMI is invalid in your region, update `ami_id` in `variable.tf` or pass with `-var`.