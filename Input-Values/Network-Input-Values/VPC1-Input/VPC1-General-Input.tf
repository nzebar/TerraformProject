
      ##### VARIABLE FOR INPUT VALUES TO BE REFERENCED BY MODULE CALL BELOW #####

##### IF CREATING NEW INSTANCE OF GROUPS AND USERS CHANGE VARIABLE AND MODULE NAME TO SOMETHING UNIQUE #####
##### ENSURE THAT BOTH VARAIBLE AND MODULE HAVE THE SAME UNIQUE NAME #####

module "VPC1" {
source = "../../../Modules/Network-Modules/VPC-Modules/Create-VPC/VPC1-General-Modules"

#################
## VPC Config. ##
#################
# Ref lines 1 - 23 of main.tf file.

    create_vpc = true
    vpc_name = "VPC1"
    cidr_block       = "10.0.0.0/16"
    assign_generated_ipv6_cidr_block = true
    enable_ipv6 = true
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    enable_classiclink = false
    enable_classiclink_dns_support = false
    
    vpc_tags = {
        "Dog" = "Nate"
    }

###############################
## VPC: Secondary CIDR Block ##
###############################

    sub_cidr_blocks = []

##############################
## DHCP Options Set Config. ##
##############################
# Ref lines 33 - 60 of main.tf file.

    enable_dhcp_options = true
    dhcp_options_set_name = "dhcp1"
    dhcp_options_domain_name = "nutsandboltz.com"
    dhcp_options_domain_name_servers = ["192.168.0.2"]
    dhcp_options_ntp_servers = []
    dhcp_options_netbios_name_servers = []
    dhcp_options_netbios_node_type = 2

    dhcp_options_tags = {
        "one" = "dhcp"
    }
}





