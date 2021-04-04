module "Create_Group_Add_Users_Module" {
source = "./Modules/Security-Modules/IAM-Modules/Create-Groups-Module"

    # Name of IAM Group & IAM Group Policy

        Group_Name_Policy_Name = "testgrouppolicy"

    # List of IAM users to have in an IAM group which can assume the role
    # Can specify users in the AWS console or users created through the "Create-User" module.

        group_users = [] 

    # List of IAM role ARNs which can be assumed by the group 

        # Can specify role ARNs from the AWS console 
        assumable_roles_aws = [] 

        # role ARNs created through "Created_Roles_Module"
        assumable_roles_create_users_module = module.Create_Roles_module.this_iam_role_arn

    }

module "Create_Users_Module" {
source = ""

}

variable "Create_Multiple_Roles" {
  description = "Map of project names to configuration."
  type        = map
  default     = {
    client-webapp = {
      create_role = true/false,
      create_instance_profile = true/false
      role_name = ""
      role_path = "/"
      role_description = ""
      custom_role_policy_arns = [""]
      number_of_custom_role_policy_arns = #
      force_detach_policies = true/false
      role_permissions_boundary_arn = ""
      trusted_role_arns = [""]
      trusted_role_services = [""]
      role_requires_mfa = true/false
      mfa_age = #
      max_session_duration = #
      tags = map""
    },
  }
}





module "Create_Roles_Module" {
source = ""
for_each = var.Create_Multiple_Roles

    #Role-Configurations:

        # Whether to create a role
            #create_role = each.value[0]
            each.key[0] = each.value 

        # Whether to create an instance profile
        # If create instance profile, create_role must be set to true. Otherwise, default is false.
            #create_instance_profile = each.value[1]
            each.key[1] = each.value

        # IAM role name
            #role_name = each.value[2]
            each.key[2] = each.value

        # Path of IAM role
            #role_path = each.value[3]
            each.key[3] = each.value

        # IAM Role description
            #role_description = each.value[4]
            each.key[4] = each.value

    # Role-Policies:

        # # List of ARNs of IAM policies to attach to IAM role
            #custom_role_policy_arns = each.value[5]
            each.key[5] = each.value

        # Number of IAM policies to attach to IAM role
        # Dependent on list length of custom_role_policy_arns 
            #number_of_custom_role_policy_arns = each.value[6]
            each.key[6] = each.value

        # Whether policies should be detached from this role when destroying
           #force_detach_policies = each.value[7]
           each.key[8] = each.value 

    # Role-Permission-Boundary:

        # Permissions boundary ARN to use for IAM role
            #role_permissions_boundary_arn = each.value[9]
            each.key[9] = each.value

    # Role-Trusts:

        # "ARNs of AWS entities who can assume these roles"
            #trusted_role_arns = each.vlaue[10]
            each.key[10] = each.value

        # AWS Services that can assume these roles    
            #trusted_role_services = each.value[11]
            each.key[11] = each.value

    # MFA-Configurations

        # Whether role requires MFA
            #role_requires_mfa = each.value[12]
            each.key[12] = each.value

        # Max age of valid MFA (in seconds) for roles which require MFA
            #mfa_age = each.value[13]
            each.key[13] = each.value 

        # Maximum CLI/API session duration in seconds between 3600 and 43200
            #max_session_duration = each.value[14]
            each.key[14] = each.value  

    # A map of tags to add to IAM role resources

        # Map of Tags
            #tags = each.value[15]
            each.key[15] = each.value

}