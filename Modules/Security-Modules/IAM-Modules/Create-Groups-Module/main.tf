data "aws_iam_policy_document" "assume_role_aws" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.assumable_roles_aws
  }
}

resource "aws_iam_policy" "this_aws_policy" {
  name        = var.Group_Name_Policy_Name
  description = "Allows to assume role in another AWS account"
  policy      = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_group" "this" {
  name = var.Group_Name_Policy_Name
}

resource "aws_iam_group_policy_attachment" "this" {
  for_each = var.assumable_roles_aws && var.assumable_roles_local 

  group      = aws_iam_group.this.id
  policy_arn = each.key
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = aws_iam_group.this.id
  name  = var.Group_Name_Policy_Name
  users = var.group_users
}
