# Beginner Guide: IAM User Management with Terraform

This folder creates AWS IAM users, IAM groups, and policy attachments from one file: `users.yaml`.

## What this does

- Creates one IAM user per entry in `users.yaml`
- Creates one IAM group per unique `group` name
- Adds each user to their group
- Attaches all listed policies to that group (deduplicated)

## Files you should know

- `users.yaml` - user list you edit
- `usercreate.tf` - Terraform resources
- `provider.tf` - AWS provider config
- `variable.tf` - input variables (`aws_region`, `users_file`)

## 1. Prerequisites

- Terraform installed
- AWS credentials configured (for example with `aws configure`)
- Permission to manage IAM users/groups/policies in your AWS account

## 2. Configure users

Edit `users.yaml`:

```yaml
users:
  - name: aman
    group: developer
    policies:
      - arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess
      - arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess

  - name: ali
    group: devops
    policies:
      - arn:aws:iam::aws:policy/AdministratorAccess
```

## 3. Run Terraform

From this folder (`AWS_Prac/user_management`):

```powershell
terraform init
terraform plan
terraform apply
```

To skip manual confirmation:

```powershell
terraform apply -auto-approve
```

## 4. Optional: change AWS region

Default region is `ap-south-1`.

Override it during apply:

```powershell
terraform apply -var="aws_region=us-east-1"
```

## 5. Clean up

```powershell
terraform destroy
```

## Notes for beginners

- IAM is global in AWS, but the provider still needs a region.
- Policies are attached to groups, not directly to users.
- If two users are in the same group, the group is created once.
