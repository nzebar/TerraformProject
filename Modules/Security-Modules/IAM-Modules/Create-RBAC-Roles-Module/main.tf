locals {
  role_sts_externalid = flatten(list(var.role_sts_externalid))
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = var.trusted_role_actions

    principals {
      type        = "AWS"
      identifiers = var.trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.trusted_role_services
    }

    dynamic "condition" {
      for_each = length(local.role_sts_externalid) != 0 ? [true] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = var.role_sts_externalid
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role_with_mfa" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.trusted_role_services
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [var.mfa_age]
    }
  }
}

resource "aws_iam_role" "this" {

  name                 = length(var.role_name) > 1 && length(var.role_name) < 64 ? var.role_name : null 
  path                 = var.role_path
  max_session_duration = var.max_session_duration
  description          = var.role_description

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.role_permission_boundary_local_path == "" ? null : file(var.role_permission_boundary_local_path)

  assume_role_policy = var.role_requires_mfa ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy" "admin_policy" {
  name        = var.admin_policy_name
  #description = var.admin_policy_description
  role = aws_iam_role.this.arn
  for_each = var.admin_role_policy_local_path

  policy = each.key == [""] ? null : file(tostring(each.key))
}

    # resource "aws_iam_role_policy_attachment" "admin_policy_attachment" {
    #   role       = var.role_name
    #   policy_arn = aws_iam_policy.admin_policy.
    # }

resource "aws_iam_role_policy" "poweruser_policy" {
  name        = var.poweruser_policy_name
  #description = var.poweruser_policy_description
  role = aws_iam_role.this.arn
  for_each = var.poweruser_role_policy_local_path 

  policy = each.key == [""] ? null : file(tostring(each.key))
}

    # resource "aws_iam_role_policy_attachment" "poweruser_policy_attachment" {
    #   #count = var.create_role 
    #   for_each = var.role_name

    #   role       = each.key
    #   policy_arn = aws_iam_policy.poweruser_policy[*]
    # }

resource "aws_iam_role_policy" "readonly_policy" {
  name        = var.readonly_policy_name
  #description = var.readonly_policy_description
  role = aws_iam_role.this.arn
  for_each = var.readonly_role_policy_local_path 

  policy = each.key == [""] ? null : file(tostring(each.key))
}

    # resource "aws_iam_role_policy_attachment" "readonly_policy_attachment" {
    #   #count = var.create_role && var.attach_readonly_policy ? 1 : 0
    #   for_each = var.role_name

    #   role       = each.key
    #   policy_arn = aws_iam_policy.readonly_policy[*]
    # }

resource "aws_iam_role_policy" "custom_policy" {
  name        = var.custom_policy_name
  #description = var.custom_policy_description
  role = aws_iam_role.this.arn
  for_each = var.custom_role_policy_local_path 

  policy = each.key == [""] ? null : file(tostring(each.key))
}

    # resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
    #   #count = var.create_role && number_of_custom_policy_local_path >= 1 ? 1 : 0
    #   for_each = var.role_name

    #   role       = each.key
    #   policy_arn = aws_iam_policy.custom_policy[*]
    # }

resource "aws_iam_instance_profile" "this" {
  count = var.create_role && var.create_instance_profile ? 1 : 0
  name  = var.role_name
  path  = var.role_path
  role  = aws_iam_role.this.name
}

