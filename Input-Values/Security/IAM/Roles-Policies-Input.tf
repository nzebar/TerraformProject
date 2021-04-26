##################################
## Variable Needed: DO NOT EDIT ##
################################## 
variable "IAM_ROLES_POLICIES" {
  description = "Map of Roles and their polices to be attached."
  type = map(any)
  default     = {

######################
## Roles & Policies ##
######################

Role1 = {

    ##### Role Settings #####
    "create_role" = ["true"]
    "create_instance_profile" = ["false"]
    "role_name" = ["template1"]
    "role_description" = ["This is a template. Copy and paste below."]
    "role_path" = ["/This/is/a/path/for/test/role/"]
    "force_detach_policies" = ["true"]

    ##### Role Trusts #####
    "trusted_role_actions" = ["sts:AssumeRole"]
    "trusted_role_arns" = ["arn:aws:iam::092968731555:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"]
    "trusted_role_services" = ["ec2.amazonaws.com"]
    "role_sts_externalid" = [""]

    ##### MFA & Session #####
    "role_requires_mfa" = ["true"]
    "mfa_age" = ["86400"]
    "max_session_duration" = ["3600"]

    ##### Permission Boundary #####
    "permission_boundary_policy_name" = ["permbound1"]
    "permission_boundary_policy_description" = ["test"]
    "permission_boundary_path" = ["/this/is/a/test/path/"]
    "role_permission_boundary_local_path" = []
    ##### Attach Policy to Role #####
    "attach_policy" = ["true"]
    "policy_name" = ["test1"]
    "policy_description" = ["yuh"]
    "policy_local_path" = []

#   tags = [tomap({
#       "test" = "test"
#       })]
}  

    }
}
























































































































































































#################
## MODULE CALL ##
#################
## DO NOT EDIT ##
#################        

module "IAM_ROLES_POLICIES" {
source = "../../../Modules/Security-Modules/IAM-Modules/Roles-Policies-Module"
for_each = var.IAM_ROLES_POLICIES

    #Role Settings:

        # Whether to create a role
            create_role = lookup(var.IAM_ROLES_POLICIES[each.key], "create_role", null)

        # Whether to create an instance profile
            create_instance_profile = lookup(var.IAM_ROLES_POLICIES[each.key], "create_instance_profile", null)

        # IAM role name
             role_name = lookup(var.IAM_ROLES_POLICIES[each.key], "role_name", null)

        # IAM Role description
            role_description = lookup(var.IAM_ROLES_POLICIES[each.key], "role_description", null)

        # IAM Role path
            role_path = lookup(var.IAM_ROLES_POLICIES[each.key], "role_path", null)

        # Whether policies should be detached from this role when destroying
           force_detach_policies = lookup(var.IAM_ROLES_POLICIES[each.key], "force_detach_policies", null)

    # Role-Trusts:

        # Actions for role trusts
            trusted_role_actions = lookup(var.IAM_ROLES_POLICIES[each.key], "trusted_role_actions", null)

        # ARNs of AWS entities who can assume these roles
            trusted_role_arns = lookup(var.IAM_ROLES_POLICIES[each.key], "trusted_role_arns", null)

        # AWS Services that can assume these roles    
             trusted_role_services = lookup(var.IAM_ROLES_POLICIES[each.key], "trusted_role_services", null)

        # STS ExternalId condition values to use with a role (when MFA is not required)
            role_sts_externalid = lookup(var.IAM_ROLES_POLICIES[each.key], "role_sts_externalid", null)

    # MFA & Session

        # Whether role requires MFA
            role_requires_mfa = lookup(var.IAM_ROLES_POLICIES[each.key], "role_requires_mfa", null)

        # Max age of valid MFA (in seconds) for roles which require MFA
            mfa_age = lookup(var.IAM_ROLES_POLICIES[each.key], "mfa_age", null)

        # Maximum CLI/API session duration in seconds between 3600 and 43200
            max_session_duration = lookup(var.IAM_ROLES_POLICIES[each.key], "max_session_duration", null)

    # Permission-Boundary:

        # Name of the permission boundary policy
            permission_boundary_policy_name = lookup(var.IAM_ROLES_POLICIES[each.key], "permission_boundary_policy_name", null)

        # Description of the permission boundary policy
           permission_boundary_policy_description = lookup(var.IAM_ROLES_POLICIES[each.key], "permission_boundary_path", null)

        # Path where the Permission Boundary policy will be located on AWS Console
             permission_boundary_path = lookup(var.IAM_ROLES_POLICIES[each.key], "permission_boundary_path", null)

        # Permissions boundary Local Path to use for IAM role
            role_permission_boundary_local_path = lookup(var.IAM_ROLES_POLICIES[each.key], "role_permission_boundary_local_path", null)

    # Policies:

        # Admin Policy

            # Whether to attach admin policy to role. Bool Answer.
                attach_policy = lookup(var.IAM_ROLES_POLICIES[each.key], "attach_policy", null)

            # Admin policy name to use for admin role
                policy_name = lookup(var.IAM_ROLES_POLICIES[each.key], "policy_name", null)

            # Admin policy description to use for admin role
                policy_description = lookup(var.IAM_ROLES_POLICIES[each.key], "policy_description", null)

            # Local file paths of admin policies to attach to role
                policy_local_path = lookup(var.IAM_ROLES_POLICIES[each.key], "policy_local_path", null)

       

    # Map of Tags
        #tags = lookup(var.IAM_ROLES_POLICIES, "tags", {"Terraform"="Role"}) 
}

        ##### END OF MODULE CALL #####