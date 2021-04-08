variable "Create_Group_Users_AssumableRoles" {
  # The corresponding documentation for each field can be found in the module below.
  description = "Create the Group, Users, and Apply Assumable Roles."
  type        = any
  default     = {
    tempalate = {
    #This is a template used to create the Group, Users, and Apply Assumable Roles.
    #Copy and paste below template for your own input.
        "group_name" = "TestGroup"
        "group_policy_name" = "TestGroupPolicyName" 
        "group_users" = [
            "TestUser1"
        ]
        "group_membership_name" = "TestMembership"
        "assumable_roles_aws" = ["arn:aws:iam:us-east-1:*:role/AdministratorAccess"]
        # Uncomment line below to enable this group to assume the roles created in Create-Multiple-Roles.tf file
        # assumable_roles_local = module.Create_Roles_local_Module.this_iam_role_arn[each.key]
    },
  }
}

module "Create_Group_Add_Users_Module" {
source = "./Modules/Security-Modules/IAM-Modules/Create-Groups-Module"
for_each = var.Create_Group_Users_AssumableRoles

    # Name of IAM Group & IAM Group Policy

        group_name = lookup(var.Create_Group_Users_AssumableRoles[each.key], "group_name", "")

        group_policy_name = lookup(var.Create_Group_Users_AssumableRoles[each.key], "group_policy_name", "")

    # List of IAM users to have in an IAM group which can assume the role
    # Can specify users in the AWS console or users created through the "Create-User" module.

        group_users = lookup(var.Create_Group_Users_AssumableRoles, "group_users", [""])

        group_membership_name = lookup(var.Create_Group_Users_AssumableRoles, "group_membership_name", "")

    # List of IAM role ARNs which can be assumed by the group 

        # Can specify role ARNs from the AWS console 
        assumable_roles_aws = lookup(var.Create_Group_Users_AssumableRoles, "assumable_roles_aws", [""])

        # Can specify roles created through the Create-Multiple-Roles.tf file
        assumable_roles_local = lookup(var.Create_Group_Users_AssumableRoles, "assumable_roles_local", [""])
    }