locals {
  users_data = yamldecode(file("${path.module}/users.yaml"))

  users = {
    for user in local.users_data.users :
    user.name => user
  }

  groups = toset([
    for user in local.users_data.users : user.group
  ])
}

# Create IAM Groups
resource "aws_iam_group" "aws_groups" {
  for_each = local.groups
  
  name = each.value
}

# Create IAM Users
resource "aws_iam_user" "aws_users" {
  for_each = local.users	

  name = each.value.name
}

# Add Users to Groups
resource "aws_iam_user_group_membership" "aws_membership" {
  for_each = local.users

  user = aws_iam_user.aws_users[each.key].name

  groups = [
    aws_iam_group.aws_groups[each.value.group].name
  ]
}

# Attach policies to groups
resource "aws_iam_group_policy_attachment" "aws_group_policies" {
  for_each = {
    for user in local.users_data.users :
    "${user.group}-${join("-", user.policies)}" => user
  }

  group      = aws_iam_group.groups[each.value.group].name
  policy_arn = each.value.policies[0]
}