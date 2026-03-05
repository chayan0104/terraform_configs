# Default VPC + EC2 + Nginx

This Terraform stack:
- Uses your AWS account's default VPC in `ap-south-1`
- Launches one `t2.micro` EC2 instance
- Attaches a security group that allows `22` and `80`
- Installs and starts Nginx with a custom `index.html` using EC2 user data

## Usage

```powershell
cd terraform_configs/AWS_Default_VPC_EC2
Copy-Item terraform.tfvars.example terraform.tfvars
terraform init
terraform apply -auto-approve
terraform output
```

To test the page:

```powershell
$url = terraform output -raw nginx_url
Invoke-WebRequest -UseBasicParsing $url | Select-Object -ExpandProperty Content
```
