data "aws_iam_policy_document" "assume_role_aws" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.assumable_roles_aws
  }
}

resource "aws_iam_policy_document" "assume_role_create_roles_module" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.assumable_roles_create_roles_module
  }
}

resource "aws_iam_policy" "this_aws_policy" {
  name        = var.Group_Name_Policy_Name
  description = "Allows to assume role in another AWS account"
  policy      = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "this_create_role_module_policy" {
  for_each = module.Create_Role_module.this_iam_role_arn

  name        = var.Group_Name_Policy_Name
  description = "Allows to assume role created through Create_Role Module"
  policy      = each.key.json
}

resource "aws_iam_group" "this" {
  name = var.Group_Name_Policy_Name
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.id
  policy_arn = aws_iam_policy.this.id
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = aws_iam_group.this.id
  name  = var.Group_Name_Policy_Name
  users = var.group_users
}
