variable "Create_Multiple_Roles" {
  description = "Map of Roles and their polices to be attached."
  type        = map
  default     = {
  # This is a template to be used for the roles and policies to be specified.
  # Copy & Paste below the template to specify your roles and policies.
  # Each Map Object specifies a new role and the policies to be attached.
  # Values for the fields to be specified are located below in the Create_Roles_local_Module
    tempalate = {
      create_role = false
      create_instance_profile = false
      role_name = "template"
      role_description = "This is a template. Copy and paste below."
      attach_admin_policy = false
      role_path = "/"
      admin_policy_name = ""
      admin_policy_description = ""
      admin_role_policy_local_path = [
          "\\Example\\Path"
          ]
      attach_poweruser_policy = false
      poweruser_policy_name = ""
      poweruser_policy_description = ""
      poweruser_role_policy_local_path = [
          "\\Example\\Path"
          ]
      attach_readonly_policy = false
      readonly_role_policy_local_path = [
          "\\Example\\Path"
          ]
      number_of_custom_role_policy_arns = 0
      custom_role_policy_local_path = [
          "\\Example\\Path"
          ]
      force_detach_policies = true
      role_permissions_boundary_arn = ""
      trusted_role_arns = [""]
      trusted_role_services = [""]
      role_requires_mfa = false
      mfa_age = 0
      max_session_duration = 0
      tags = {
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
            #create_role = each.value[0]
            #each.key[0] = each.value 
            create_role = each.key[0]

        # Whether to create an instance profile
            #create_instance_profile = each.value[1]
            #each.key[1] = each.value
            create_instance_profile = each.key[1]

        # IAM role name
            #role_name = each.value[2]
            #each.key[2] = each.value
            role_name = each.key[2]

        # IAM Role description
            #role_description = each.value[4]
            #each.key[4] = each.value
            role_description = each.key[4]

        # IAM Role path
            #role_path = each.value[5]
            #each.key[5] = each.value
            role_path = each.key[5]

    # Role-Policies:

        # Wheather to attach admin policy to role. Bool Answer.
            #attach_admin_policy = each.value[6]
            #each.key[6] = each.value
            attach_admin_policy = each.key[6]

                # Admin policy name to use for admin role
                    #admin_policy_name = each.value[7]
                    #each.key[7] = each.value
                    admin_policy_name = each.key[7]

                # Admin policy description to use for admin role
                    #admin_policy_description = each.value[8]
                    #each.key[8] = each.value
                    admin_policy_description = each.key[8]

                # Local file paths of admin policies to attach to role
                    #admin_role_policy_local_path = each.value[9]
                    #each.key[9] = each.value
                    admin_role_policy_local_path = var.Create_Multiple_Roles[admin_role_policy_local_path]

        # Whether to attach PowerUser policy to role. Bool Answer.
            #attach_poweruser_policy_local_path = each.value[10]
            #each.key[10] = each.value
            attach_poweruser_policy_local_path = each.key[10]

                # Poweruser policy name to use for poweruser role
                    #poweruser_policy_name = each.value[11]
                    #each.key[11] = each.value 
                    poweruser_policy_name = each.key[11]

                # Poweruser policy description to use for poweruser role
                    #poweruser_policy_description = each.value[12]
                    #each.key[12] = each.value
                    poweruser_policy_description = each.key[12]

                # Local file paths of PowerUser policies to attach to role
                    #poweruser_role_policy_local_path = each.value[13]
                    #each.key[13] = each.value
                    poweruser_role_policy_local_path = var.Create_Multiple_Roles[poweruser_role_policy_local_path]

        # Whether to attach ReadOny policy to role. Bool Answer.
            #attach_admin_policy = each.value[14]
            #each.key[14] = each.value
            attach_readonly_policy = each.key[14]

                # Readnly policy name to use for readonly role
                    #readonly_policy_name = each.value[15]
                    #each.key[15] = each.value
                    readonly_policy_name = each.value[15]

                # Readonly policy description to use for readonly role
                    #readonly_policy_description = each.value[16]
                    #each.key[16] = each.value
                    readonly_policy_description = each.key[16]

                # Local file paths of ReadOnly policies to attach to role
                    #readonly_role_policy_local_path = each.value[17]
                    #each.key[17] = each.value
                    readonly_role_policy_local_path = var.Create_Multiple_Roles[readonly_role_policy_local_path]

        # Number of Custom local role policies to attach to the role
            #number_of_custom_role_policy_arns = each.value[18]
            #each.key[18] = each.value
            number_of_custom_role_policy_arns = each.key[18]

            # Local file paths of custom policies to attach to role
                #custom_role_policy_arns = each.value[19]
                #each.key[19] = each.value
                custom_role_policy_arns = var.Create_Multiple_Roles[custom_role_policy_arns]

    # Force Detach Policy:

        # Whether policies should be detached from this role when destroying
           #force_detach_policies = each.value[20]
           #each.key[20] = each.value
           force_detach_policies = each.key[20] 

    # Role-Permission-Boundary:

        # Permissions boundary ARN to use for IAM role
            #role_permissions_boundary_arn = each.value[21]
            #each.key[21] = each.value
            role_permission_boundary_arn = each.key[21]

    # Role-Trusts:

        # "ARNs of AWS entities who can assume these roles"
            #trusted_role_arns = each.vlaue[22]
            #each.key[22] = each.value
            trusted_role_arns = each.key[22]

        # AWS Services that can assume these roles    
            #trusted_role_services = each.value[23]
            #each.key[23] = each.value
            trusted_role_services = each.key[23]

    # MFA-Configurations

        # Whether role requires MFA
            #role_requires_mfa = each.value[24]
            #each.key[24] = each.value
            role_requires_mfa = each.key[24]

        # Max age of valid MFA (in seconds) for roles which require MFA
            #mfa_age = each.value[25]
            #each.key[25] = each.value
            mfa_age = each.key[25] 

        # Maximum CLI/API session duration in seconds between 3600 and 43200
            #max_session_duration = each.value[26]
            #each.key[26] = each.value
            max_session_duration = each.key[26]  

    # A map of tags to add to IAM role resources

        # Map of Tags
            #tags = each.value[27]
            #each.key[27] = each.value
            tags = each.key[27]

}