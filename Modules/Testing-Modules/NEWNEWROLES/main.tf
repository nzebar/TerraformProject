locals {

  trusts = flatten(
    [ for role in var.Roles:
        [ for trusts, trust_settings in role: trusts if trusts == "trust" ]
      ]
  )

  mfa = flatten(
    [ for role in var.Roles:
        [ for mfa, mfa_settings in role: mfa if mfa == "MFA" ]
      ]
  )

  permission_boundary = flatten(
   [ for role, role_settings in var.Roles:
       [ for Permission_Boundary, Permission_Boundary_Settings in role_settings: Permission_Boundary_Settings if Permission_Boundary == "Permission_Boundary" ] 
      ]
  )

  policies = flatten(
      [ for role, role_settings in var.Roles: 
        [ for New_Policies in role_settings: New_Policies if New_Policies == "New_Policies" ] 
      ]
  )
}

data "aws_iam_policy_document" "assume_role" {

  statement {
    effect = "Allow"

    actions = [ for o, i in local.trusts: i if o == "trusted_role_actions" ]

    dynamic "principals" {
    for_each = { for o in local.trusts: [ for z in o.trusted_role_arns: z ]=> o }
        content {
        type        = "AWS"
        identifiers = each.value.trusted_role_arns
        } 
    }

    dynamic "principals" {
    for_each = { for o in local.trusts: [ for z in o.trusted_role_services: z ] => o }
      
        content {
        type        = "Service"
        identifiers = each.value.trusted_role_services
        }
    }

    dynamic "condition" {
    for_each = { for o in local.trusts: [ for z in o.role_sts_externalid: z ] => o }

      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = each.value.role_sts_externalid
      } 
    }
  }
}

data "aws_iam_policy_document" "assume_role_with_mfa" {
  statement {
    effect = "Allow"

    actions = [ for o, i in local.trusts: i if o == "trusted_role_actions" ]

   dynamic "principals" {
    for_each = { for o in local.trusts: [ for z in o.trusted_role_arns: z ]=> o }
        content {
        type        = "AWS"
        identifiers = each.value.trusted_role_arns
        } 
    }

    dynamic "principals" {
    for_each = { for o in local.trusts: [ for z in o.trusted_role_services: z ]=> o }
      
        content {
        type        = "Service"
        identifiers = each.value.trusted_role_services
        }
    }

    dynamic "condition" {
    for_each = { for o in local.trusts: [ for z in o.role_sts_externalid: z ]=> o }

      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = each.value.role_sts_externalid
      } 
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = [ for o, i in local.mfa: i if o == "role_requires_mfa" ]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [ for o, i in local.mfa: i if o == "mfa_age" ]
    }
  }
}

resource "aws_iam_role" "this" {
for_each = var.Roles

  name                 = lookup(var.Roles[each.key], "name", "")  
  path                 = lookup(var.Roles[each.key], "path", "")
  max_session_duration = lookup(var.Roles[each.key], "max_session_duration", "")
  description          = lookup(var.Roles[each.key], "description", "")

  force_detach_policies = lookup(var.Roles[each.key], "force_detach_policies", "")
 
  permissions_boundary = aws_iam_policy.permission_boundary[[for k, o in var.Roles: o if o == "Permission_Boundary"]].arn

  assume_role_policy = [ for d, g in local.mfa: g if d == "role_requires_mfa" ] == true ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json

  tags = lookup(var.Roles[each.key], "Role_Tags", {})
}

resource "aws_iam_policy" "permission_boundary" {
for_each = { for o, k in local.permission_boundary: "${"name"}.${"description"}.${"path"}.${"local_path_json_file"}" => k }

  name        = each.value.name
  path        = each.value.path
  description = each.value.description

  policy = file(each.value.local_path_json_file)
}

resource "aws_iam_policy" "policy" {
for_each = { for o, k in local.policies: "${"name"}.${"description"}.${"path"}.${"local_path_json_file"}" => k }

  name        = each.value.name 
  path        = each.value.path
  description = each.value.description

  policy = file(each.value.local_path_json_file)
}

# resource "aws_iam_role_policy_attachment" "policy-attach" {
# for_each = var.Roles

#   role       = lookup(var.Roles[each.key], "name", null)
#   policy_arn = [for ]
# }