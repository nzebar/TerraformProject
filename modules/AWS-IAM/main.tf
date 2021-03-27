terraform {
  required_providers {
     aws = {
      source  = "hashicorp/aws" //The source for where to pull terraform modules from
     # version = "~> 2.0" //Pull all compatible modules above version 2.70 
     }
  }
}

resource "aws_iam_group" "create_group" {
    name = var.group_name
    path = var.group_put_path
}

resource "aws_iam_user_group_membership" "add_group_users" {
    for_each = module.create_group.add_users

    user = each.key 
    groups = [var.group_name]
}

resource "aws_iam_role" "create_role" {
  name = var.role_name
  path = var.role_put_path
  permissions_boundary = aws_iam_policy.create_permission_boundary.arn

  assume_role_policy = jsonencode(
{
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = [ 
            ${var.trust_policy_string}
        ]
      }
    ]
  })

  tags = {
    tag-key = var.role_name
  }
}

resource "aws_iam_policy" "create_policy" {
  name        = var.policy_name
  path = var.policy_put_path
  description = var.policy_description

  policy = file(var.policy_get_location)
}

resource "aws_iam_role_policy_attachment" "ecr_developer_role1_policy1_attachment" {
  role       = aws_iam_role.create_role.name
  policy_arn = aws_iam_policy.create_policy.arn
}

resource "aws_iam_policy" "create_permission_boundary" {
  name        = var.permission_boundary.name
  path = var.permission_boundary_put_path
  description = var.permission_boundary_description

  policy = file(var.permission_boundary_get_location)
}