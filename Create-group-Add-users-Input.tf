variable "Create_Group_Users_AssumableRoles" {
  # The corresponding documentation for each field can be found in the module below.
  description = "Create the Group, Users, and Apply Assumable Roles."
  type        = map
  default     = {
    tempalate = {
    #This is a template used to create the Group, Users, and Apply Assumable Roles.
    #Copy and paste below template for your own input.
        Group_Name_Policy_Name = "" 
        group_users = [
            "EampleUser1",
            "ExampleUser2,"
            "ExampleUser3",
            #uncomment line below to add the created users from Create_Users_Module below to the group.
            # module.Create_Users_module.created_users_output
        ]
        assumable_roles_aws = [""]
        # Uncomment line below to enable this group to assume the roles created in Create-Multiple-Roles.tf file
        # assumable_roles_local = module.Create_Roles_local_Module.this_iam_role_arn[each.key]
    },
  }
}

module "Create_Group_Add_Users_Module" {
source = "./Modules/Security-Modules/IAM-Modules/Create-Groups-Module"
for_each = var.Create_Group_Users_AssumableRoles

    # Name of IAM Group & IAM Group Policy

        #Group_Name_Policy_Name = each.value[0]
        each.key[0] = each.value

    # List of IAM users to have in an IAM group which can assume the role
    # Can specify users in the AWS console or users created through the "Create-User" module.

        #group_users = each.value[1]
        each.key[1] = each.value

    # List of IAM role ARNs which can be assumed by the group 

        # Can specify role ARNs from the AWS console 
        #assumable_roles_aws = each.value[2] 
        each.key[2] = each.value

        # Can specify roles created through the Create-Multiple-Roles.tf file
        #assumable_roles_local = each.value[3]
        each.key[3] = each.value



    }

module "Create_Users_Module" {
source = "./Modules/Security-Modules/IAM-Modules/Create-Groups-Module"




}