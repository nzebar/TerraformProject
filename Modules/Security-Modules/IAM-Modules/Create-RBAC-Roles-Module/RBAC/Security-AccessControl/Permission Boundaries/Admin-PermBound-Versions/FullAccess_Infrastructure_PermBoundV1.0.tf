{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyAccessToCostAndBilling",
            "Effect": "Deny",
            "Action": [
                "account:*",
                "aws-portal:*",
                "savingsplans:*",
                "cur:*",
                "ce:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "DenyPermBoundaryIAMPolicyAlteration",
            "Effect": "Deny",
            "Action": [
                "iam:DeletePolicy",
                "iam:DeletePolicyVersion",
                "iam:CreatePolicyVersion",
                "iam:SetDefaultPolicyVersion"
            ],
            "Resource": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
            ]
        },
        {
            "Sid": "DenyRemovalOfPermBoundaryFromAnyUserOrRole",
            "Effect": "Deny",
            "Action": [
                "iam:DeleteUserPermissionsBoundary",
                "iam:DeleteRolePermissionsBoundary"
            ],
            "Resource": [
                "arn:aws:iam::YourAccount_ID:user/*",
                "arn:aws:iam::YourAccount_ID:role/*"
            ],
            "Condition": {
                "StringEquals": {
                    "iam:PermissionsBoundary": "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
                }
            }
        },
        {
            "Sid": "DenyAccessIfRequiredPermBoundaryIsNotBeingApplied",
            "Effect": "Deny",
            "Action": [
                "iam:PutUserPermissionsBoundary",
                "iam:PutRolePermissionsBoundary"
            ],
            "Resource": [
                "arn:aws:iam::YourAccount_ID:user/*",
                "arn:aws:iam::YourAccount_ID:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
                }
            }
        },
        {
            "Sid": "DenyUserAndRoleCreationWithOutPermBoundary",
            "Effect": "Deny",
            "Action": [
                "iam:CreateUser",
                "iam:CreateRole"
            ],
            "Resource": [
                "arn:aws:iam::YourAccount_ID:user/*",
                "arn:aws:iam::YourAccount_ID:role/*"
            ],
            "Condition": {
                "StringNotEquals": {
                    "iam:PermissionsBoundary": "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
                }
            }
        },
        {
          "Sid": "AllowUserGroupManagementOnlyInTheSpecifiedLocation",
          "Effect": "Allow",
          "Action": [
            "iam:CreateGroup",
            "iam:UpdateGroup",
            "iam:DeleteGroup",
            "iam:AddUserToGroup",
            "iam:RemoveUserFromGroup",
            "iam:ChangePassword",
            "iam:CreateUser",
            "iam:UpdateUser",
            "iam:DeleteUser",
            "iam:CreateLoginProfile",
            "iam:UpdateLoginProfile",
            "iam:DeleteLoginProfile",
            "iam:CreateAccountAlias",
            "iam:DeleteAccountAlias",
            "iam:CreateAccessKey",
            "iam:UpdateAccessKey",
            "iam:DeleteAccessKey",
            "iam:CreateVirtualMFADevice",
            "iam:ResyncMFADevice",
            "iam:DeactivateMFADevice",
            "iam:DeleteVirtualMFADevice"
          ],
          "Resource": [
            "${module.Create_Group_Add_Users_Module.group_arn}"
          ],
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
          "Sid": "AllowUserGroupManagementOnlyInTheSpecifiedLocation",
          "Effect": "Allow",
          "Action": [
            "iam:ChangePassword",
            "iam:UpdateLoginProfile",
            "iam:CreateAccountAlias",
            "iam:DeleteAccountAlias"
          ],
          "Resource": [
            "@{aws:username}"
          ],
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
          "Sid": "AllowManageOwnVirtualMFADevice",
          "Effect": "Allow",
          "Action": [
              "iam:CreateVirtualMFADevice",
              "iam:DeleteVirtualMFADevice"
          ],
          "Resource": "@{aws:username}",
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}
              ]
            }
          }
        },
        {
          "Sid": "AllowManageOwnUserMFA",
          "Effect": "Allow",
          "Action": [
              "iam:DeactivateMFADevice",
              "iam:EnableMFADevice",
              "iam:ResyncMFADevice"
          ],
          "Resource": "@{aws:username}",
          "condition" : {
            "StringEquals": {
              "iam:PermissionBoundary": [
                "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
            "Sid": "DenyAllExceptListedIfNoMFA",
            "Effect": "Deny",
            "NotAction": [
                "iam:CreateVirtualMFADevice",
                "iam:EnableMFADevice",
                "iam:GetUser",
                "iam:ListMFADevices",
                "iam:ListVirtualMFADevices",
                "iam:ResyncMFADevice",
                "sts:GetSessionToken"
            ],
            "Resource": "*",
            "Condition": {
                "BoolIfExists": {"aws:MultiFactorAuthPresent": "false"}
            }
        },
        {
        "Sid": "AllowPolicyManagementOnlyInSpecifiedLocation",
        "Effect": "Allow",
        "Action": [
          "iam:AttachGroupPolicy",
          "iam:AttachRolePolicy",
          "iam:AttachUserPolicy",
          "iam:CreatePolicy",
          "iam:CreatePolicyVersion",
          "iam:DeletePolicy",
          "iam:DeletePolicyVersion",
          "iam:DeleteRolePolicy",
          "iam:DeleteUserPolicy",
          "iam:DetachRolePolicy",
          "iam:DetachUserPolicy",
          "iam:PutGroupPolicy",
          "iam:PutRolePermissionBoundary",
          "iam:PutRolePolicy",
          "iam:PutUserPermissionBoundary",
          "iam:UpdateAssumeRolePolicy",
          "iam:TagPolicy",
          "iam:UntagPolicy"
        ],
        "Resource": [
            "${module.Create_Group_Add_Users_Module.group_arn}"
        ],
        "condition" : {
          "StringEquals": {
            "iam:PermissionBoundary": [
              "${module.Create_Roles_local_Module.this_iam_policy_permissions_boundary}"
              ]
            }
          }
        },
        {
            "Effect": "Allow",
            "Action": [
                "seretsmanager:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "acm:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ram:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "waf:*",
                "wafv2:*",
                "waf-regional:*"
            ],
            "Resource": "*"
        }
    ]
}