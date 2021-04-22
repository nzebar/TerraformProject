
      ##### VARIABLE FOR INPUT VALUES TO BE REFERENCED BY MODULE CALL BELOW #####

##### IF CREATING NEW INSTANCE OF GROUPS AND USERS CHANGE VARIABLE AND MODULE NAME TO SOMETHING UNIQUE #####
##### ENSURE THAT BOTH VARAIBLE AND MODULE HAVE THE SAME UNIQUE NAME #####

module "VPC1" {
source = "../../../Modules/Network-Modules/VPC-Modules/Create-VPC"

#################
## VPC Config. ##
#################
# Ref lines 1 - 23 of main.tf file.

    create_vpc = true
    vpc_name = "VPC1"
    cidr_block       = "10.0.0.0/16"
    secondary_cidr_blocks = []
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
##############################
## DHCP Options Set Config. ##
##############################
# Ref lines 33 - 60 of main.tf file.

    enable_dhcp_options = false
    dhcp_options_set_name = "dhcp1"
    dhcp_options_domain_name = "nutsandboltz.com"
    dhcp_options_domain_name_servers = ["192.168.0.2"]
    dhcp_options_ntp_servers = []
    dhcp_options_netbios_name_servers = []
    dhcp_options_netbios_node_type = 2

    dhcp_options_tags = {
        "one" = "dhcp"
    }
#############################
## Internet Gateway Config ##
#############################
# Ref lines 62 - 78 of main.tf file.

    create_igw = true
    igw_name = "igwone"
    igw_tags = {
        "igw" = "one"
    }

##########################################
## Egress Only Internet Gateway Config. ##
##########################################
# Ref lines 80 - 96 of main.tf file.

   create_egress_only_igw = false
   egress_only_igw_name = "egressIGW" 
   egress_igw_tags = {
       "egress" = "igw"
   }

#################################
## Default Routes Config. ##
#################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
# Ref lines 98 - 132 of main.tf file.

    manage_default_route_table = true
    default_route_table_propagating_vgws = [] 
    default_route_table_routes = {}

    default_route_table_name = "dummy default"
    default_route_table_tags = {
        "hey" = "yo"
    }
       
tags = {
    "dhcp" = "one"
    }


################################
## Public Route Table Config. ##
################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Ref lines 134 - 170 of main.tf file.

    manage_public_route_table = true

    public_route_table_propagating_vgws = []
    public_route_table_routes = {
        cidr_block = "0.0.0.0/0"
    }

    public_route_table_name = "PublicRouteTable"
    public_route_table_tags = {
        "route" = "table"
    }

################################
## Private Route Table Config. ##
################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Ref lines 172 - 208 of main.tf file.

    manage_private_route_table = true

    private_route_table_routes = {
        cidr_block = "192.168.0.0/16"
    }

    private_route_table_name = "PrivateRouteTable"
    private_route_table_tags = {
        "private" = "table"
    }

##################################
## Database Route Table Config. ##
##################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Ref lines 209 - 244 of main.tf file.

    manage_database_route_table = true

    database_route_table_routes = {
        cidr_block = "192.168.0.0/16"
    }

    database_route_table_name = "DatabaseRouteTable"
    database_route_table_tags = {
        "private" = "database"
    }

########################
## Availability Zones ##
########################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
# Ref lines 243 - 262 of main.tf file.

    include_all_availability_zones = true
    filter_az_by_state = ""
    filter_az_by_name_value = {}
    excluded_zone_names = []
    excluded_zone_ids = []

#############################
## Declared Public Subnets ##
#############################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# Ref lines 265 - 305 of main.tf file.
# If you would like to not create these resources, comment out the lines referenced above.

public_subnets = {
    subnet1 = {
        "cidr_block" = ["192.168.1.0/24"]
        "availability_zone" = ["us-east-1a"]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "public_subnet_name" = [""]
        "tags" = [{
            "key" = "value",
        }]

        "public_route_table_association" = ["id"]

    }

    subnet2 = {
        "cidr_block" = ["192.168.2.0/24"]
        "availability_zone" = ["us-east-1b"]
        "availability_zone_id" = [""]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "public_subnet_name" = [""]
        "tags" = [{
            "key" = "value",
        }]

        public_route_table_association = ["id"]

    }
}

##############################
## Declared Private Subnets ##
##############################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# Ref lines 307 - 347 of main.tf file.
# If you would like to not create these resources, comment out the lines referenced above.

private_subnets = {
    subnet1 = {
        "cidr_block" = ["192.168.3.0/24"]
        "availability_zone" = ["us-east-1a"]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "private_subnet_name" = [""]
        "tags" = [{
            "key" = "value",
        }]

        "public_route_table_association" = ["id"]

    }

    subnet2 = {
        "cidr_block" = ["192.168.4.0/24"]
        "availability_zone" = ["us-east-1b"]
        "availability_zone_id" = [""]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "private_subnet_name" = [""]
        "tags" = [{
            "key" = "value",
        }]

        public_route_table_association = ["id"]

    }
}

##############################
## Declared Database Subnets ##
##############################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# Ref lines 265 - 305 of main.tf file.
# If you would like to not create these resources, comment out the lines referenced above.

database_subnets = {
    subnet1 = {
        "cidr_block" = ["192.168.5.0/24"]
        "availability_zone" = ["us-east-1a"]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "database_subnet_name" = [""]
        "tags" = [{
            "key" = "value",
        }]

        "public_route_table_association" = ["id"]

    }

    subnet2 = {
        "cidr_block" = ["192.168.6.0/24"]
        "availability_zone" = ["us-east-1b"]
        "availability_zone_id" = [""]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "database_subnet_name" = [""]
        "tags" = [{
            "key" = "value",
        }]

        public_route_table_association = ["id"]

    }

    subnet3 = {
        "cidr_block" = ["192.168.7.0/24"]
        "availability_zone" = ["us-east-1c"]
        "availability_zone_id" = [""]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "public_subnet_name" = [""]
        "tags" = [{
            "key" = "value",
        }]

        public_route_table_association = ["id"]

    }
}

}














