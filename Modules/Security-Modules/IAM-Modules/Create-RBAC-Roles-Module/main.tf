# locals {
#   role_sts_externalid = flatten(list(var.role_sts_externalid))
# }

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

    condition {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = var.role_sts_externalid
    }
  }
}

data "aws_iam_policy_document" "assume_role_with_mfa" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.trusted_role_arns  == [] ? ["*"] : var.trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.trusted_role_services  == [] ? ["*"] : var.trusted_role_services
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = var.mfa_age
    }
  }
}

resource "aws_iam_role" "this" {
  name                 = element(var.role_name, 0)
  path                 = element(var.role_path, 0)
  max_session_duration = element(var.max_session_duration, 0)
  description          = element(var.role_description, 0)

  force_detach_policies = tobool(var.force_detach_policies[0])
 
  permissions_boundary = aws_iam_policy.permission_boundary_policy.arn == "" ? "" : aws_iam_policy.permission_boundary_policy.arn

  assume_role_policy = element(var.role_requires_mfa, 0) == "true" ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}

resource "aws_iam_policy" "permission_boundary_policy" {
  name        = length(element(var.permission_boundary_policy_name, 0)) == 0 ? null : element(var.permission_boundary_policy_name, 0)
  description = element(var.permission_boundary_policy_description, 0)
  path = element(var.permission_boundary_path, 0) == "" ? null : element(var.permission_boundary_path, 0)

  policy = templatefile(element(var.role_permission_boundary_local_path, 0), {permission_boundary_path = element(var.permission_boundary_path, 0), permission_boundary_name = element(var.permission_boundary_policy_name, 0)})

}

resource "aws_iam_role_policy" "admin_policy" {
  name        = element(var.attach_admin_policy, 0) == "true" ? element(var.admin_policy_name, 0) : ""
  #description = element(var.admin_policy_description, 0)
  role = element(var.attach_admin_policy, 0) == "true" ? aws_iam_role.this.name : ""
  for_each = toset([ for k in var.admin_role_policy_local_path: k if k != [""] ])

  policy = templatefile(each.key, {permission_boundary_path = element(var.permission_boundary_path, 0), permission_boundary_name = element(var.permission_boundary_policy_name, 0)})

}

resource "aws_iam_role_policy" "poweruser_policy" {
  name        = element(var.attach_poweruser_policy, 0) == "true" ? element(var.poweruser_policy_name, 0) : ""
  #description = element(var.poweruser_policy_description, 0)
  role = element(var.attach_poweruser_policy, 0) == "true" ? aws_iam_role.this.name : ""
  for_each = toset([ for k in var.poweruser_role_policy_local_path: k if k != "" ])

  policy = templatefile(each.key, {permission_boundary_path = element(var.permission_boundary_path, 0), permission_boundary_name = element(var.permission_boundary_policy_name, 0)})
}

resource "aws_iam_role_policy" "readonly_policy" {
  name        = element(var.attach_readonly_policy, 0) == "true" ? element(var.readonly_policy_name, 0) : ""
  #description = element(var.readonly_policy_description, 0)
  role = element(var.attach_readonly_policy, 0) == "true" ? aws_iam_role.this.name : ""
  for_each =  toset([ for k in var.readonly_role_policy_local_path: k if k != "" ])

  policy = templatefile(each.key, {permission_boundary_path = element(var.permission_boundary_path, 0), permission_boundary_name = element(var.permission_boundary_policy_name, 0)})
}

resource "aws_iam_role_policy" "custom_policy" {
  name        = length(var.custom_role_policy_local_path) != 0 ? element(var.custom_policy_name, 0) : ""
  #description = length(var.custom_policy_name) element(var.custom_policy_description, 0) 
  role = length(var.custom_role_policy_local_path) != 0 ? aws_iam_role.this.name : ""
  for_each = toset([ for k in var.custom_role_policy_local_path: k if k != "" ])

  policy = templatefile(each.key, {permission_boundary_path = element(var.permission_boundary_path, 0), permission_boundary_name = element(var.permission_boundary_policy_name, 0)})
    
  }

resource "aws_iam_instance_profile" "this" {
  count = tobool(element(var.create_role, 0)) && tobool(element(var.create_instance_profile,0)) ? 1 : 0
  name  = element(var.role_name, 0)
  path  = element(var.role_path, 0)
  role  = aws_iam_role.this.name
}

