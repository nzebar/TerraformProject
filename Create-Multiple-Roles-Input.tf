variable "Create_Multiple_Roles" {
  description = "Map of Roles and their polices to be attached."
  type        = any
  default     = {
  # This is a template to be used for the roles and policies to be specified.
  # Copy & Paste below the template to specify your roles and policies.
  # Each Map Object specifies a new role and the policies to be attached.
  # Values for the fields to be specified are located below in the Create_Roles_local_Module
    tempalate = {
      "create_role" = false
      "create_instance_profile" = "false"
      "role_name" = "template"
      "role_description" = "This is a template. Copy and paste below."
      "role_path" = "/"
      "attach_admin_policy" = ""
      "admin_policy_name" = ""
      "admin_policy_description" = ""
      "admin_role_policy_local_path" = [
          "Example\\Path"
          ]
      "attach_poweruser_policy_local_path" = "false"
      "poweruser_policy_name" = ""
      "poweruser_policy_description" = ""
      "poweruser_role_policy_local_path" = []
      "attach_readonly_policy" = "false"
      "readonly_role_policy_local_path" = []
      "custom_policy_name" = ""
      "custom_policy_description" = ""
      "number_of_custom_policy_local_path" = 0
      "custom_role_policy_local_path" = [
          "Example\\Path"
      ]
      "force_detach_policies" = "true"
      "role_permission_boundary_local_path" = ""
      "trusted_role_arns" = [""]
      "trusted_role_services" = [""]
      "role_sts_externalid" = []
      "role_requires_mfa" = "false"
      "mfa_age" = "0"
      "max_session_duration" = "0"
      "tags" = {
          "test" = "test"
      }
    },
  }
}

module "Create_Roles_local_Module" {
source = "./Modules/Security-Modules/IAM-Modules/Create-RBAC-Roles-Module"
for_each = var.Create_Multiple_Roles

    #Role-Configurations:

        # Whether to create a role
            create_role = tobool(lookup(var.Create_Multiple_Roles, "create_role", false))

        # Whether to create an instance profile
            create_instance_profile = tobool(lookup(var.Create_Multiple_Roles, "create_instance_profile", false))

        # IAM role name
            role_name = lookup(var.Create_Multiple_Roles, "role_name", "")

        # IAM Role description
            role_description = lookup(var.Create_Multiple_Roles, "role_description", "")

        # IAM Role path
            role_path = lookup(var.Create_Multiple_Roles, "role_path", "/")

    # Role-Policies:

        # Whether to attach admin policy to role. Bool Answer.
            attach_admin_policy = tobool(lookup(var.Create_Multiple_Roles, "attach_admin_policy", "false"))

                # Admin policy name to use for admin role
                    admin_policy_name = lookup(var.Create_Multiple_Roles, "admin_policy_name", "")

                # Admin policy description to use for admin role
                    admin_policy_description = lookup(var.Create_Multiple_Roles, "admin_policy_description", "")

                # Local file paths of admin policies to attach to role
                    admin_role_policy_local_path = lookup(var.Create_Multiple_Roles, "admin_role_policy_local_path", [])

        # Whether to attach PowerUser policy to role. Bool Answer.
            attach_poweruser_policy = tobool(lookup(var.Create_Multiple_Roles, "attach_poweruser_policy", "false"))

                # Poweruser policy name to use for poweruser role
                    poweruser_policy_name = lookup(var.Create_Multiple_Roles, "poweruser_policy_name", "")

                # Poweruser policy description to use for poweruser role
                    poweruser_policy_description = lookup(var.Create_Multiple_Roles, "poweruser_policy_description", "")

                # Local file paths of PowerUser policies to attach to role
                    poweruser_role_policy_local_path = lookup(var.Create_Multiple_Roles, "poweruser_role_policy_local_path", [])

        # Whether to attach ReadOny policy to role. Bool Answer.
            attach_readonly_policy = tobool(lookup(var.Create_Multiple_Roles, "attach_readonly_policy", "false"))

                # Readnly policy name to use for readonly role
                    readonly_policy_name = lookup(var.Create_Multiple_Roles, "readonly_policy_name", "")

                # Readonly policy description to use for readonly role

                    readonly_policy_description = lookup(var.Create_Multiple_Roles, "readonly_policy_description", "")

                # Local file paths of ReadOnly policies to attach to role
                    readonly_role_policy_local_path = lookup(var.Create_Multiple_Roles, "readonly_role_policy_local_path", [])

        # Number of Custom local role policies to attach to the role
            number_of_custom_policy_local_path = tonumber(lookup(var.Create_Multiple_Roles, "number_of_custom_role_policy_local_path", "0"))

                # Custom policy name to use for the role
                    custom_policy_name = lookup(var.Create_Multiple_Roles, "custom_policy_name", "")

                # Custom policy description to use for the role
                    custom_policy_description = lookup(var.Create_Multiple_Roles, "custom_policy_description", "")

                # Local file paths for custom IAM policies to attach to IAM role
                    custom_role_policy_local_path = lookup(var.Create_Multiple_Roles, "custom_role_policy_local_path", [])

    # Force Detach Policy:

        # Whether policies should be detached from this role when destroying
           force_detach_policies = lookup(var.Create_Multiple_Roles, "force_detach_policies", false)

    # Role-Permission-Boundary:

        # Permissions boundary ARN to use for IAM role
            role_permission_boundary_local_path = lookup(var.Create_Multiple_Roles, "role_permission_boundary_local_path", "")

    # Role-Trusts:

        # "ARNs of AWS entities who can assume these roles"
            trusted_role_arns = lookup(var.Create_Multiple_Roles, "trusted_role_arns", [])

        # AWS Services that can assume these roles    
            trusted_role_services = lookup(var.Create_Multiple_Roles, "trusted_role_services", [])

        # STS ExternalId condition values to use with a role (when MFA is not required)"\
            role_sts_externalid = lookup(var.Create_Multiple_Roles, "role_sts_externalid", [])

    # MFA-Configurations

        # Whether role requires MFA
            role_requires_mfa = tobool(lookup(var.Create_Multiple_Roles, "role_requires_mfa", "false"))

        # Max age of valid MFA (in seconds) for roles which require MFA
            mfa_age = tonumber(lookup(var.Create_Multiple_Roles, "mfa_age", "43200"))

        # Maximum CLI/API session duration in seconds between 3600 and 43200
            max_session_duration = tonumber(lookup(var.Create_Multiple_Roles, "max_session_duration", "43200")) 

    # A map of tags to add to IAM role resources

        # Map of Tags
            tags = lookup(var.Create_Multiple_Roles, "tags", {"Terraform"="Role"}) 

}