module "VPC_VPC1" {
source = "../../Modules/Network-Modules/Default-modules/VPC-Modules-Default"

#################
## VPC Config. ##
#################

    create_vpc = true
    vpc_name = "VPC1"
    cidr_block       = "192.168.0.0/16"
    assign_generated_ipv6_cidr_block = false
    enable_ipv6 = false
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    enable_classiclink = false
    enable_classiclink_dns_support = false
    
    vpc_tags = {
        "VPC" = "VPC_VPC1"
    }

################################
## VPC: Associated CIDR Block ##
################################

    associate_cidr_blocks = false
    cidr_blocks_associated = []

##############################
## DHCP Options Set Config. ##
##############################

    enable_dhcp_options = false
    dhcp_options_set_name = "DHCP_VPC1"
    dhcp_options_domain_name = "nutsandboltz.com"
    dhcp_options_domain_name_servers = ["192.168.0.2"]
    dhcp_options_ntp_servers = []
    dhcp_options_netbios_name_servers = []
    dhcp_options_netbios_node_type = 2

    dhcp_options_tags = {
        "DHCP" = "DHCP_VPC1"
    }



}