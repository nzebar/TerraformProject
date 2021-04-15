variable "Create_Multiple_Roles" {
  description = "Map of Roles and their polices to be attached."
  type = map(any)
  default     = {
      Template = {
      ##### Role Settings #####
      "create_role" = ["true"]
      "create_instance_profile" = ["false"]
      "role_name" = ["template"]
      "role_description" = ["This is a template. Copy and paste below."]
      "role_path" = ["/"]
      "force_detach_policies" = ["true"]
      ##### Role Trusts #####
      "trusted_role_actions" = ["sts:AssumeRole"]
      "trusted_role_arns" = ["arn:aws:iam::092968731555:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"]
      "trusted_role_services" = ["ec2.amazonaws.com"]
      "role_sts_externalid" = [""]
      ##### MFA & Session #####
      "role_requires_mfa" = ["false"]
      "mfa_age" = ["86400"]
      "max_session_duration" = ["3600"]
      ##### Permission Boundary #####
      "permission_boundary_policy_name" = ["testpermbound"]
      "permission_boundary_policy_description" = ["test"]
      "permission_boundary_path" = [""]
      "role_permission_boundary_local_path" = ["Modules\\Security-Modules\\IAM-Modules\\Create-RBAC-Roles-Module\\RBAC\\Security-AccessControl\\Permission Boundaries\\Admin-PermBound-Versions\\FullAccess_AccessManagement_PermBoundV1.0.tf"]
      ##### Admin Policy #####
      "attach_admin_policy" = ["true"]
      "admin_policy_name" = ["test1356"]
      "admin_policy_description" = ["yuh"]
      "admin_role_policy_local_path" = ["Modules\\Security-Modules\\IAM-Modules\\Create-RBAC-Roles-Module\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"]
      ##### PowerUser Policy #####
      "attach_poweruser_policy_local_path" = ["false"]
      "poweruser_policy_name" = ["test5432"]
      "poweruser_policy_description" = [""]
      "poweruser_role_policy_local_path" = [""]
      ##### ReadOnly Policy #####
      "attach_readonly_policy" = ["true"]
      "readonly_role_policy_local_path" = [""]
      ##### Custom Policy #####
      "custom_policy_name" = ["test765778"]
      "custom_policy_description" = [""]
      "number_of_custom_policy_local_path" = ["0"]
      "custom_role_policy_local_path" = [""]

    #   tags = [tomap({
    #       "test" = "test"
    #       })]
     } 
    }
}



module "Create_Roles_local_Module" {
source = "./Modules/Security-Modules/IAM-Modules/Create-RBAC-Roles-Module"
for_each = var.Create_Multiple_Roles

    #Role Settings:

        # Whether to create a role
            create_role = lookup(var.Create_Multiple_Roles[each.key], "create_role", null)

        # Whether to create an instance profile
            create_instance_profile = lookup(var.Create_Multiple_Roles[each.key], "create_instance_profile", null)

        # IAM role name
            #role_name = [ for role_name in var.Create_Multiple_Roles["role.name"]: role_name if var.Create_Multiple_Roles["create_role"] == ["true"] ]
             role_name = lookup(var.Create_Multiple_Roles[each.key], "role_name", null)

        # IAM Role description
            #role_description = element([ for role_description in var.Create_Multiple_Roles["role_description"]: role_description if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)
            role_description = lookup(var.Create_Multiple_Roles[each.key], "role_description", null)

        # IAM Role path
            #role_path = element([ for role_path in var.Create_Multiple_Roles["role_path"]: role_path if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)
            role_path = lookup(var.Create_Multiple_Roles[each.key], "role_path", null)

        # Whether policies should be detached from this role when destroying
           force_detach_policies = lookup(var.Create_Multiple_Roles[each.key], "force_detach_policies", null)

    # Role-Trusts:

        # Actions for role trusts
            #trusted_role_actions = element([ for trusted_role_actions in var.Create_Multiple_Roles: trusted_role_actions if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)
            trusted_role_actions = lookup(var.Create_Multiple_Roles[each.key], "trusted_role_actions", null)

        # ARNs of AWS entities who can assume these roles
            #trusted_role_arns = var.Create_Multiple_Roles["trusted_role_arns"]
            trusted_role_arns = lookup(var.Create_Multiple_Roles[each.key], "trusted_role_arns", null)
            #trusted_role_arns = element([ for trusted_role_arns in var.Create_Multiple_Roles: trusted_role_arns if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)

        # AWS Services that can assume these roles    
             trusted_role_services = lookup(var.Create_Multiple_Roles[each.key], "trusted_role_services", null)
            #trusted_role_services = element([ for trusted_role_services in var.Create_Multiple_Roles: trusted_role_services if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)

        # STS ExternalId condition values to use with a role (when MFA is not required)
            role_sts_externalid = lookup(var.Create_Multiple_Roles[each.key], "role_sts_externalid", null)
            #role_sts_externalid = element([ for role_sts_externalid in var.Create_Multiple_Roles: role_sts_externalid if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)

    # MFA & Session

        # Whether role requires MFA
            #role_requires_mfa = element([ for role_requires_mfa in var.Create_Multiple_Roles: role_requires_mfa if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)
            role_requires_mfa = lookup(var.Create_Multiple_Roles[each.key], "role_requires_mfa", null)

        # Max age of valid MFA (in seconds) for roles which require MFA
            #mfa_age = element([ for mfa_age in var.Create_Multiple_Roles: mfa_age if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)
            mfa_age = lookup(var.Create_Multiple_Roles[each.key], "mfa_age", null)

        # Maximum CLI/API session duration in seconds between 3600 and 43200
            #max_session_duration = element([ for max_session_duration in var.Create_Multiple_Roles: max_session_duration if var.Create_Multiple_Roles["create_role"] == ["true"] ], 0)
            max_session_duration = lookup(var.Create_Multiple_Roles[each.key], "max_session_duration", null)

    # Permission-Boundary:

        # Name of the permission boundary policy
            #permission_boundary_policy_name = [ for permission_boundary_policy_name in var.Create_Multiple_Roles: permission_boundary_policy_name if "create_role" == ["true"] ]
            permission_boundary_policy_name = lookup(var.Create_Multiple_Roles[each.key], "permission_boundary_policy_name", null)

        # Description of the permission boundary policy
            #permission_boundary_policy_description = [ for permission_boundary_policy_description in var.Create_Multiple_Roles: permission_boundary_policy_description if "create_role" == ["true"] ]
           permission_boundary_policy_description = lookup(var.Create_Multiple_Roles[each.key], "permission_boundary_path", null)

        # Path where the Permission Boundary policy will be located on AWS Console
            # permission_boundary_path = [ for permission_boundary_type in var.Create_Multiple_Roles: permission_boundary_type if "create_role" == ["true"] ]
             permission_boundary_path = lookup(var.Create_Multiple_Roles[each.key], "permission_boundary_path", null)

        # Permissions boundary Local Path to use for IAM role
            #role_permission_boundary_local_path = [ for role_permission_boundary_local_path in each.value: role_permission_boundary_local_path if "create_role" == ["true"] ]
            role_permission_boundary_local_path = lookup(var.Create_Multiple_Roles[each.key], "role_permission_boundary_local_path", null)

    # Policies:

        # Admin Policy

            # Whether to attach admin policy to role. Bool Answer.
                attach_admin_policy = lookup(var.Create_Multiple_Roles[each.key], "attach_admin_policy", null)

            # Admin policy name to use for admin role
                #admin_policy_name = [ for admin_policy_name in var.Create_Multiple_Roles: admin_policy_name if "attach_admin_policy" == ["true"] ]
                admin_policy_name = lookup(var.Create_Multiple_Roles[each.key], "admin_policy_name", null)

            # Admin policy description to use for admin role
                admin_policy_description = lookup(var.Create_Multiple_Roles[each.key], "admin_policy_description", null)

            # Local file paths of admin policies to attach to role
                # admin_role_policy_local_path = [ for admin_role_policy_local_path in var.Create_Multiple_Roles: admin_role_policy_local_path if "attach_admin_policy" == ["true"] ]
                admin_role_policy_local_path = lookup(var.Create_Multiple_Roles[each.key], "admin_role_policy_local_path", null)

        # PowerUsers Policy

            # Whether to attach PowerUser policy to role. Bool Answer.
                attach_poweruser_policy = lookup(var.Create_Multiple_Roles[each.key], "attach_poweruser_policy", null)

            # Poweruser policy name to use for poweruser role
                poweruser_policy_name = lookup(var.Create_Multiple_Roles[each.key], "poweruser_policy_name", null)
                #poweruser_policy_name = [ for poweruser_policy_name in var.Create_Multiple_Roles: poweruser_policy_name if "attach_poweruser_policy" == ["true"] ]

            # Poweruser policy description to use for poweruser role
                # poweruser_policy_description = [ for poweruser_policy_description in var.Create_Multiple_Roles: poweruser_policy_description if "attach_poweruser_policy" == ["true"] ]
                 poweruser_policy_description = lookup(var.Create_Multiple_Roles[each.key], "poweruser_policy_description", null)

            # Local file paths of PowerUser policies to attach to role
               # poweruser_role_policy_local_path = [ for poweruser_role_policy_local_path in var.Create_Multiple_Roles: poweruser_role_policy_local_path if "attach_poweruser_policy" == ["true"] ]
               poweruser_role_policy_local_path = lookup(var.Create_Multiple_Roles[each.key], "poweruser_role_policy_local_path", null)

        # ReadOnly Policy

            # Whether to attach ReadOny policy to role. Bool Answer.
                attach_readonly_policy = lookup(var.Create_Multiple_Roles[each.key], "attach_readonly_policy", null)

            # Readnly policy name to use for readonly role
               # readonly_policy_name = element([ for readonly_policy_name in var.Create_Multiple_Roles: readonly_policy_name if var.Create_Multiple_Roles["attach_readonly_policy"] == ["true"] ], 0)
               readonly_policy_name = lookup(var.Create_Multiple_Roles[each.key], "readonly_policy_name", null)

            # Readonly policy description to use for readonly role
              #  readonly_policy_description = element([ for readonly_policy_description in var.Create_Multiple_Roles: readonly_policy_description if var.Create_Multiple_Roles["attach_readonly_policy"] == ["true"] ], 0)
               readonly_policy_description = lookup(var.Create_Multiple_Roles[each.key], "readonly_policy_description", null)

            # Local file paths of ReadOnly policies to attach to role
               # readonly_role_policy_local_path = element([ for readonly_role_policy_local_path in var.Create_Multiple_Roles: readonly_role_policy_local_path if var.Create_Multiple_Roles["attach_readonly_policy"] == ["true"] ], 0)
                readonly_role_policy_local_path = lookup(var.Create_Multiple_Roles[each.key], "readonly_role_policy_local_path", null)

        # Custom Policy

            # Number of Custom local role policies to attach to the role
                number_of_custom_policy_local_path = lookup(var.Create_Multiple_Roles[each.key], "number_of_custom_role_policy_local_path", null)

            # Custom policy name to use for the role
                #custom_policy_name = element([ for custom_policy_name in var.Create_Multiple_Roles: custom_policy_name if length(var.Create_Multiple_Roles["number_of_custom_policy_local_path"]) > 0 ], 0)
                custom_policy_name = lookup(var.Create_Multiple_Roles[each.key], "custom_policy_name", null)

            # Custom policy description to use for the role
                #custom_policy_description = element([ for custom_policy_description in var.Create_Multiple_Roles: custom_policy_description if length(var.Create_Multiple_Roles["number_of_custom_policy_local_path"]) > 0], 0)
                 custom_policy_description = lookup(var.Create_Multiple_Roles[each.key], "custom_policy_description", null)

            # Local file paths for custom IAM policies to attach to IAM role
                #custom_role_policy_local_path = element(values(each.key[ [for custom_role_policy_local_path in var.Create_Multiple_Roles[each.key]: custom_role_policy_local_path if length("number_of_custom_policy_local_path") > 0]]), 0)
                 custom_role_policy_local_path = lookup(var.Create_Multiple_Roles[each.key], "custom_role_policy_local_path", null)


    # Map of Tags
        #tags = lookup(var.Create_Multiple_Roles, "tags", {"Terraform"="Role"}) 

}

