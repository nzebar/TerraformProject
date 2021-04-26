module "ROLES_POLICIES" {
    source = "../../../Modules/Security-Modules/IAM-Modules/NEW_ROLES_POLICIES_MODULE"

######################
## Roles & Policies ##
######################
Roles_Policies = {

    Role1 = {
        ##### Role Settings #####
            create_role = true
            create_instance_profile = false
            role_name = "template1"
            instance_profile_name = ""
            role_path = "/This/is/a/path/for/test/role/"
            role_description = "his is a template. Copy and paste below."
            force_detach_policies = true
        ##### Role Trusts #####
            trusted_role_actions = "sts:AssumeRole"
            trusted_role_arns = [""]
            trusted_role_services = []
            role_sts_externalid = []
        ##### MFA & Session #####
            role_requires_mfa = true
            mfa_age = 86400
            max_session_duration = 3600
        ##### Permission Boundary #####
            permission_boundary_policy_name = "permbound1"
            permission_boundary_policy_description = "test"
            permission_boundary_path = "/this/is/a/test/path/"
            role_permission_boundary_local_path = [""]
        ##### Attach Policy to Role #####
            attach_policy = "true"
            policy_name = "test1"
            policy_path = "/this/is/a/policy/test/path/"
            policy_description = "yuh"
            policy_local_path = []

        ##### Tags #####
        Role_Tags = {
            "acl" = "database"
            }
        Policy_Tags = {
            "acl" = "database"
            }
        Permission_Boundary_Tags = {
            "acl" = "database"
            }
        }

}
  
}