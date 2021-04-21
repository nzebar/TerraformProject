###################
## VPC Variables ##
###################

variable "create_vpc" {
    type = bool
    default = false
}

variable "vpc_name" {
    type = string
    default = "VPC"
}

variable "tags" {
    type = map(string)
    default = {}
}

variable "vpc_tags" {
    type = map(string)
    default = {}
}

variable "cidr_block" {
    type = string
    default = ""
}

variable "secondary_cidr_blocks" {
    type = list(string)
    default = []
}


variable "assign_generated_ipv6_cidr_block" {
    type = bool
    default = false
}

variable "enable_ipv6" {
    type = bool
    default = false
}

variable "instance_tenancy" {
    type = string
    default = ""
}

variable "enable_dns_support" {
    type = bool
    default = false
}

variable "enable_dns_hostnames" {
    type = bool
    default = false
}

variable "enable_classiclink" {
    type = bool
    default = false
}

variable "enable_classiclink_dns_support" {
    type = bool
    default = false
}

################################
## Internet Gateway Variables ##
################################

variable "create_igw" {
    type = bool
    default = false
}

variable "igw_name" {
    type = string
    default = ""
}

variable "igw_tags" {
    type = map(string)
    default = {}
}

variable "create_egress_only_igw" {
    type = bool
    default = false
}

variable "egress_only_igw_name" {
    type = string
    default = ""
}

variable "egress_igw_tags" {
    type = map(string)
    default = {}
}

variable "enable_dhcp_options" {
    type = bool
    default = false
}

variable "dhcp_options_domain_name" {
    type = string
    default = ""
}

################################
## DHCP Options Set Variables ##
################################

variable "dhcp_options_domain_name_servers" {
    type = list(string)
    default = []
}

variable "dhcp_options_ntp_servers" {
    type = list(string)
    default = []
}

variable "dhcp_options_netbios_name_servers" {
    type = list(string)
    default = []
}

variable "dhcp_options_netbios_node_type" {
    type = number
    default = 2
}

variable "dhcp_options_set_name" {
    type = string
    default = ""
}

variable "dhcp_options_tags" {
    type = map(string)
    default = {}
}

###################################
## Default Routes Variables ##
###################################

variable "manage_default_route_table" {
    type = bool
    default = false
}

variable "default_route_table_propagating_vgws" {
    type = list(string)
    default = []
}

variable "default_route_table_routes" {
    type = map(string)
    default = {}
}

variable "default_route_table_name" {
    type = string
    default = ""
}

variable "default_route_table_tags" {
    type = map(string)
    default = {}
}

##################################
## Public Route Table Variables ##
##################################

variable "manage_public_route_table" {
    type = bool
    default = false
}

variable "public_route_table_propagating_vgws" {
    type = list(string)
    default = []
}

variable "public_route_table_routes" {
    type = map(string)
    default = {}
}

variable "public_route_table_name" {
    type = string
    default = ""
}

variable "public_route_table_tags" {
    type = map(string)
    default = {}
}

##################################
## Private Route Table Variables ##
##################################

variable "manage_private_route_table" {
    type = bool
    default = false
}

variable "private_route_table_routes" {
    type = map(string)
    default = {}
}

variable "private_route_table_name" {
    type = string
    default = ""
}

variable "private_route_table_tags" {
    type = map(string)
    default = {}
}

##################################
## Database Route Table Variables ##
##################################

variable "manage_database_route_table" {
    type = bool
    default = false
}

variable "database_route_table_routes" {
    type = map(string)
    default = {}
}

variable "database_route_table_name" {
    type = string
    default = ""
}

variable "database_route_table_tags" {
    type = map(string)
    default = {}
}

##################################
## Availability Zones Variables ##
##################################

variable "include_all_availability_zones" {
    type = bool
    default = false
}

variable "filter_az_by_state" {
    type = string
    default = ""
}

variable "filter_az_by_name_value" {
    type = map(string)
    default = {}
}

variable "excluded_zone_names" {
    type = list(string)
    default = []
}

variable "excluded_zone_ids" {
    type = list(string)
    default = []
}

##############################
## Public Subnets Variables ##
##############################

variable "manage_public_subnets" {
    type = bool
    default = false
}

variable "public_subnets" {
    type = map(any)
    default = {}
}