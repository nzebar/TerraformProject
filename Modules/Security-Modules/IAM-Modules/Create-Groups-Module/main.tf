data "aws_iam_policy_document" "assume_roles" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = concat(var.assumable_roles_aws, var.assumable_roles_local)
  }
}

resource "aws_iam_policy" "this_policy" {
  name        = var.group_policy_name
  description = "Allows to assume role in another AWS account" 

  policy      = data.aws_iam_policy_document.assume_roles.json
}

resource "aws_iam_group" "this" {
  name = var.group_name
}

resource "aws_iam_group_policy_attachment" "group_assumable_roles" {

  group      = aws_iam_group.this.id
  policy_arn = aws_iam_policy.this_policy.arn
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = var.group_name
  name  = var.group_membership_name
  users = var.group_users
}
