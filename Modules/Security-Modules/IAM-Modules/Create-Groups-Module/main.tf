resource "aws_iam_group" "this" {
  name = element(var.group_name, 0)
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = element(var.group_name, 0)
  name  = element(var.group_membership_name, 0)
  users = var.group_users
}

resource "aws_iam_policy" "this_policy" {
  name        = element(var.group_policy_name, 0)
  description = "Allows to assume role in another AWS account" 
  path = element(put_path_aws_group_policy, 0)

  policy      = file(element(var.group_policy_local_path, 0))
}

resource "aws_iam_group_policy_attachment" "group_assumable_roles" {
  group      = aws_iam_group.this.id
  policy_arn = aws_iam_policy.this_policy.arn
}