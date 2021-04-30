module "IAM_ROLES_POLICIES" {
source = "../../Modules/Testing-Modules/NEWNEWROLES"
Roles = {
    Role1 = {
        name = "Test"
        description = "Test Description"
        path = "/"
        force_detach_policies = false
        max_session_duration = 25365
        Trusts = {
                trusted_role_actions = "sts:AssumRole"
                trusted_role_arns = "arn:aws:iam::092968731555:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"
                trusted_role_services = "ec2.amazonaws.com"
                role_sts_externalid = ""
                }
        MFA = {
                role_requires_mfa = false
                mfa_age = "3600"
            }
        Permission_Boundary = {
                existing_permission_boundary_arn = ""
                # Create new Permissions Boubdary
                "name" = "testPermBound"
                "description" = "Permbound Description"
                "path" = "/"
                "local_path_json_file" = "Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"
            }
        Add_Existing_Policies = {
            "arn" = "arnValue"
            }
        New_Policies = {
            Policy1 = {
                    "name" = "TestPolicy1"
                    "description" = "Desc1"
                    "path" = ""
                    "local_path_json_file" = "Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"
                    }
            # Policy1 = {
            #         "name" = ""
            #         "description" = ""
            #         "path" = ""
            #         "local_path_json_file" = "Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf" 
            #         }   
            }

        Role_Tags ={
            "Key" = "Value"
        }
        Policy_Tags ={
            "Key" = "Value"
        }

    }
}






















}



















































































































