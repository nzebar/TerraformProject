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
 
  permissions_boundary = length(var.role_permission_boundary_local_path) > 0 ? aws_iam_policy.permission_boundary_policy[0].arn : ""

  assume_role_policy = element(var.role_requires_mfa, 0) == "true" ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}

resource "aws_iam_policy" "permission_boundary_policy" {
  name        = length(element(var.permission_boundary_policy_name, 0)) == 0 ? null : element(var.permission_boundary_policy_name, 0)
  description = element(var.permission_boundary_policy_description, 0)
  path = element(var.permission_boundary_path, 0) == "" ? null : element(var.permission_boundary_path, 0)
  count = length(var.role_permission_boundary_local_path) > 0 ? 1 : 0

  policy = templatefile( var.role_permission_boundary_local_path[count.index] , {permission_boundary_path = element(var.permission_boundary_path, 0), permission_boundary_name = element(var.permission_boundary_policy_name, 0)}) 
}

resource "aws_iam_role_policy" "policy" {
  name        = element(var.attach_policy, 0) == "true" ? element(var.policy_name, 0) : ""
  #description = element(var.policy_description, 0)
  role = element(var.attach_policy, 0) == "true" ? aws_iam_role.this.name : ""
  for_each = toset([ for k in var.policy_local_path: k if k != "" ])

  policy = templatefile(each.key, {permission_boundary_path = element(var.permission_boundary_path, 0), permission_boundary_name = element(var.permission_boundary_policy_name, 0)})

}


resource "aws_iam_instance_profile" "this" {
  count = tobool(element(var.create_role, 0)) && tobool(element(var.create_instance_profile,0)) ? 1 : 0
  name  = element(var.role_name, 0)
  path  = element(var.role_path, 0)
  role  = aws_iam_role.this.name
}

