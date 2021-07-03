module "EFS" {
    source = "../../Modules/Storage-Modules/Default-Modules/EFS-Modules"

#########################
## Elasitc File System ##
#########################
create_efs_file_systems = true

efs_file_systems = {

    efs_1 = {
        ## General ##
        creation_token = "Wordpress_EFS_001"
        ## Mount Targets ##
        availability_zone_name = "" # Specify AZ for One-Zone EFS
        mount_targets = {
            target_1 = {
                module_key = "subnet-us-east-1a"
                ip_address = ""
                subnet_id = module.VPC_VPC1.private_subnet_1.id
                new_subnet = {
                    enabled = false
                    vpc_id = ""
                    cidr_block = ""
                    availability_zone = "us-east-1a"
                    subnet_tags = { "key" = "value" }
                }
                security_groups = []
                new_security_group = {
                    enabled = true
                    name = "Wordpress_EFS_Security_Group_001" # Required Must Be Unique
                    description = "Security Group for Wordpress EFS 001"
                    vpc_id = module.VPC_VPC1.vpc.id
                    ingress_protocol_ports = ["tcp.2049.2049"] # "protocol.fromport.toport"
                    ingress_security_groups = []
                    ingress_ipv4_cidr_blocks = [module.VPC_VPC1.private_subnet_1.cidr_block]
                    ingress_ipv6_cidr_blocks = []
                    security_group_tags = { "mount_point_security_group" = "subnet-us-east-1a"}
            }}
            target_2 = {
                module_key = "subnet-us-east-1b"
                ip_address = ""
                subnet_id = module.VPC_VPC1.private_subnet_2.id
                new_subnet = {
                    enabled = false
                    vpc_id = ""
                    cidr_block = ""
                    availability_zone = "us-east-1a"
                    subnet_tags = { "key" = "value" }
                }
                security_groups = []
                new_security_group = {
                    enabled = true
                    name = "Wordpress_EFS_Security_Group_002" # Required Must Be Unique
                    description = "Security Group for Wordpress EFS 002"
                    vpc_id = module.VPC_VPC1.vpc.id
                    ingress_protocol_ports = ["tcp.2049.2049"] # "protocol.fromport.toport"
                    ingress_security_groups = []
                    ingress_ipv4_cidr_blocks = [module.VPC_VPC1.private_subnet_2.cidr_block]
                    ingress_ipv6_cidr_blocks = []
                    security_group_tags = { "mount_point_security_group" = "subnet-us-east-1b"}
            }}
        }
        ## Access Point ##
        create_access_point = false
        access_point = {
            root_directory = {
                enabled = true
                path = "/"
                creation_info = {
                    owner_gid = 0
                    owner_uid = 0
                    permissions = 444
            }}
            posix_user = {
                enabled = false
                gid = 789
                secondary_gids = [91011]
                uid = 121314
            }
        }
        ## Performance ##
        performance_mode = "maxIO"
        throughput_mode = "bursting"
        provisioned_throughput_in_mibps = 0
        ## Security ##
        efs_policy_local_path = "Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"
        encrypted = true
        kms_key_id = ""
        new_kms_key = {
            enabled = true
            description = "Wordpress_EFS_001_KMS_001" # Required, must be unqiue
            enable_key_rotation = false
            deletion_window_in_days = 7
            policy = ""
            kms_tags = { "Key" = "Value" }
        }
        ## Lifecycle ##
        enable_lifecycle_policy = false
        lifecycle_policy = { transition_to_ia = "" }
        ## Tags ##
        tags = {
            "Wordpress_EFS" = "Wordpress_EFS_001"
        }
    }

    

}





    
}