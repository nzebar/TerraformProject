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

variable "subnets" {
    type = map(object({
        subnet_name = string
        vpc_id = string
        cidr_block = string
        availability_zone = string
        customer_owned_ipv4_pool = string
        assign_ipv6_address_on_creation = bool
        ipv6_cidr_block = string
        map_customer_owned_ip_on_launch = bool
        map_public_ip_on_launch = bool
        outpost_arn = string
        route_table_association = string
        tags = map(string)

    }))
    default = null
}






