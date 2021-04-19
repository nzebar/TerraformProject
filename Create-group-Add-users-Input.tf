variable "Create_Group_Users_AssumableRoles" {
  # The corresponding documentation for each field can be found in the module below.
  description = "Create the Group, Users, and Apply Assumable Roles."
  type        = map(any)
  default     = {
    tempalate = {
    ##### Group Settings #####
        "name_group" = ["TestGroup"]
        "path_group" = ["/this/is/a/test/group/path/"]
        ## Group Policy Settings ##
        "group_policy_name" = ["TestGroupPolicyName"]
        "put_path_aws_group_policy" = ["/this/is/the/way/"]
        "group_policy_local_path" = ["Modules\\Security-Modules\\IAM-Modules\\Create-RBAC-Roles-Module\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"] 

    ##### Group Memebership Settings #####
      "membership_name" = ["testGroupmembName"]
        ## Add Existing Users to Group ##
        "add_existing_console_users" = [""]

        ## Create/Add Console Users to Group ##
        "users_with_console_access" = ["user1", "user2", "user3"]
        "password_reset_required" = ["true"]
        "put_path_console_users" = ["/this/test/path/"]
        ## To Decrypt passwords generated to give to users use these Commands:
        ## terraform output password | base64 --decode | keybase pgp decrypt
        
        ## Give programmatic access to select new users from above list ##
        "create_access_keys" = {
            "user1" = "keybase:scrumlord",
            "user2" = "keybase:scrumlord",
            "user3" = "keybase:scrumlord"
        }

        "force_destroy" = ["true"]
    },
  }




  
}


module "Create_Group_Add_Users_Module" {
source = "./Modules/Security-Modules/IAM-Modules/Create-Groups-Module"
for_each = var.Create_Group_Users_AssumableRoles

    # Name of IAM Group & IAM Group Policy

        name_group = lookup(var.Create_Group_Users_AssumableRoles[each.key], "name_group" == [""] ? null : "name_group", null)

        path_group = lookup(var.Create_Group_Users_AssumableRoles[each.key], "path_group", [""])

        membership_name = lookup(var.Create_Group_Users_AssumableRoles[each.key], "membership_name", [""])

        group_policy_name = lookup(var.Create_Group_Users_AssumableRoles[each.key], "group_policy_name", [""])

        put_path_aws_group_policy = lookup(var.Create_Group_Users_AssumableRoles[each.key], "put_path_aws_group_policy", [""])

        group_policy_local_path = lookup(var.Create_Group_Users_AssumableRoles[each.key], "group_policy_local_path", [])

    # List of IAM users to have in an IAM group which can assume the role
    # Can specify users in the AWS console or users created through the "Create-User" module.

        add_existing_console_users = lookup(var.Create_Group_Users_AssumableRoles[each.key], "add_existing_console_users" == [""] ? null : "add_existing_console_users", [""])

        users_with_console_access = lookup(var.Create_Group_Users_AssumableRoles[each.key], "users_with_console_access", [""])

        password_reset_required = lookup(var.Create_Group_Users_AssumableRoles[each.key], "password_reset_required", ["true"])

        put_path_console_users = lookup(var.Create_Group_Users_AssumableRoles[each.key], "put_path_console_users", [""])

        create_access_keys = lookup(var.Create_Group_Users_AssumableRoles[each.key], "create_access_keys", [{}])

        force_destroy = lookup(var.Create_Group_Users_AssumableRoles[each.key], "force_destroy", ["false"])
    } 

