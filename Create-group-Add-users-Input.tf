variable "Create_Group_Users_AssumableRoles" {
  # The corresponding documentation for each field can be found in the module below.
  description = "Create the Group, Users, and Apply Assumable Roles."
  type        = map(any)
  default     = {
    tempalate = {
        "name_group" = ["TestGroup"]
        "path_group" = ["/this/is/a test/group/path/"]
        "group_members" = ["TestMembership"]
        "group_policy_name" = ["TestGroupPolicyName"]
        "put_path_aws_group_policy" = [""]
        "group_policy_local_path" = [""] 

        "new_aws_console_users_with_password" = [
            "user1" = "password1",
            "user2" = "password2",
            "user3" = "password3"
        ]
        "aws_console_user_password_reset" = ["true"]

        "new_programmatic_users_with_pgp_key" = [
            "user1" = "pgpkey1",
            "user2" = "pgpkey2",
            "user3" = "pgpkey3"
        ]
    },
  }




  
}


module "Create_Group_Add_Users_Module" {
source = "./Modules/Security-Modules/IAM-Modules/Create-Groups-Module"
for_each = var.Create_Group_Users_AssumableRoles

    # Name of IAM Group & IAM Group Policy

        name_group = lookup(var.Create_Group_Users_AssumableRoles[each.key], "name_group" == [""] ? null : "name_group", null)

        path_group = lookup(var.Create_Group_Users_AssumableRoles[each.key], "path_group", [""])

        group_members = lookup(var.Create_Group_Users_AssumableRoles[each.key], "group_members", [""])

        group_policy_name = lookup(var.Create_Group_Users_AssumableRoles[each.key], "group_policy_name", [""])

        put_path_aws_group_policy = lookup(var.Create_Group_Users_AssumableRoles[each.key], "put_path_aws_group_policy", [""])

        group_policy_local_path = lookup(var.Create_Group_Users_AssumableRoles[each.key], "group_policy_local_path", [""])

    # List of IAM users to have in an IAM group which can assume the role
    # Can specify users in the AWS console or users created through the "Create-User" module.

        new_aws_console_users_with_password = lookup(var.Create_Group_Users_AssumableRoles[each.key], for k in "new_aws_console_users_with_password": k => tomap(k) if k != ""

        aws_console_user_password_reset = lookup(var.Create_Group_Users_AssumableRoles[each.key], "aws_console_user_password_reset", ["false"])

        new_programmatic_users_with_pgp_key = lookup(var.Create_Group_Users_AssumableRoles[each.key], for k in "new_programmatic_users_with_pgp_key": k => tomap(k) if k != ""
    } 

