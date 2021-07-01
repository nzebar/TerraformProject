module "EFS" {
    source = "../../Modules/Storage-Modules/Default-Modules/EFS-Modules"

#########################
## Elasitc File System ##
#########################
create_efs_file_systems = true

efs_file_systems = {

    efs_1 = {
        ## General ##
        creation_token = "EFS_Token_Yuh"
        ## Mount Targets ##
        availability_zone_name = "" # Specify AZ for One-Zone EFS
        mount_targets = {
            target_1 = {
                module_key = "target1"
                ip_address = ""
                subnet_id = ""
                new_subnet = {
                    enabled = true
                    vpc_id = ""
                    cidr_block = "192.168.7.0/24"
                    availability_zone = "us-east-1a"
                    subnet_tags = { "key" = "value" }
                }
                security_groups = []
                new_security_group = {
                    enabled = true
                    name = "efs_secgrp1" # Required Must Be Unique
                    description = "Description YUH"
                    vpc_id = "vpcyuh"
                    ingress_protocol_ports = ["tcp.2049.2049"] # "protocol.fromport.toport"
                    ingress_security_groups = []
                    ingress_ipv4_cidr_blocks = ["0.0.0.0/0"]
                    ingress_ipv6_cidr_blocks = []
                    security_group_tags = { "severless_security_groups" = "serverless_2_security_group_1"}
            }}
            target_2 = {
                module_key = "target2"
                ip_address = ""
                subnet_id = ""
                new_subnet = {
                    enabled = true
                    vpc_id = ""
                    cidr_block = "192.168.8.0/24"
                    availability_zone = "us-east-1a"
                    subnet_tags = { "key" = "value" }
                }
                security_groups = []
                new_security_group = {
                    enabled = true
                    name = "efs_secgrp2" # Required Must Be Unique
                    description = "Description YUH"
                    vpc_id = "yuhvpc"
                    ingress_protocol_ports = ["tcp.2049.2049"] # "protocol.fromport.toport"
                    ingress_security_groups = []
                    ingress_ipv4_cidr_blocks = ["0.0.0.0/0"]
                    ingress_ipv6_cidr_blocks = []
                    security_group_tags = { "severless_security_groups" = "serverless_2_security_group_1"}
            }}
        }
        ## Access Point ##
        create_access_point = true
        access_point = {
            root_directory = {
                enabled = true
                path = ""
                creation_info = {
                    owner_gid = 123
                    owner_uid = 456
                    permissions = 755
            }}
            posix_user = {
                enabled = true
                gid = 789
                secondary_gids = [91011]
                uid = 121314
            }
        }
        ## Performance ##
        performance_mode = "generalPurpose"
        throughput_mode = "provisioned"
        provisioned_throughput_in_mibps = 500
        ## Security ##
        efs_policy_local_path = "Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"
        encrypted = true
        kms_key_id = ""
        new_kms_key = {
            enabled = true
            description = "kms_yuh" # Required, must be unqiue
            enable_key_rotation = false
            deletion_window_in_days = 7
            policy = ""
            kms_tags = { "Key" = "Value" }
        }
        ## Lifecycle ##
        enable_lifecycle_policy = true
        lifecycle_policy = { transition_to_ia = "" }
        ## Tags ##
        tags = {
            "key" = "value"
        }
    }

    efs_2 = {
        ## General ##
        creation_token = "EFS_Token_Yuh"
        ## Mount Targets ##
        availability_zone_name = "" # Specify AZ for One-Zone EFS
        mount_targets = {
            target_1 = {    
                module_key = "target3"
                ip_address = ""
                subnet_id = ""
                new_subnet = {
                    enabled = true
                    vpc_id = ""
                    cidr_block = "192.168.9.0/24"
                    availability_zone = "us-east-1a"
                    subnet_tags = { "key" = "value" }
                }
                security_groups = []
                new_security_group = {
                    enabled = true
                    name = "efs_secgrp3" # Required Must Be Unique
                    description = "Description YUH"
                    vpc_id = "vpcyuh"
                    ingress_protocol_ports = ["tcp.2049.2049"] # "protocol.fromport.toport"
                    ingress_security_groups = []
                    ingress_ipv4_cidr_blocks = ["0.0.0.0/0"]
                    ingress_ipv6_cidr_blocks = []
                    security_group_tags = { "severless_security_groups" = "serverless_2_security_group_1"}
            }}
        }
        ## Access Point ##
        create_access_point = true
        access_point = {
            root_directory = {
                enabled = true
                path = ""
                creation_info = {
                    owner_gid = 123
                    owner_uid = 456
                    permissions = 755
            }}
            posix_user = {
                enabled = true
                gid = 789
                secondary_gids = [91011]
                uid = 121314
            }
        }
        ## Performance ##
        performance_mode = "generalPurpose"
        throughput_mode = "provisioned"
        provisioned_throughput_in_mibps = 500
        ## Security ##
        efs_policy_local_path = "Input-Values\\Security\\IAM\\RBAC\\Security-AccessControl\\Policies\\Admin-Policy-Versions\\FullAccess_AccessManagement_Policy1.0.tf"
        encrypted = true
        kms_key_id = ""
        new_kms_key = {
            enabled = true
            description = "kms_yuh2" # Required, must be unqiue
            enable_key_rotation = false
            deletion_window_in_days = 7
            policy = ""
            kms_tags = { "Key" = "Value" }
        }
        ## Lifecycle ##
        enable_lifecycle_policy = true
        lifecycle_policy = { transition_to_ia = "" }
        ## Tags ##
        tags = {
            "key" = "value"
        }
    }

    

}





    
}