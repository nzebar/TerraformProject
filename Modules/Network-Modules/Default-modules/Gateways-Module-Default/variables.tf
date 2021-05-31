################################
## Internet Gateway Variables ##
################################

variable "internet_gateways" {
    type = map(object({
        igw_name = string
        vpc_id = string
        tags = map(string)
    }))
    default = {}
}

############################################
## Egress Only Internet Gateway Variables ##
############################################

variable "egress_internet_gateways" {
    type = map(object({
        egress_igw_name = string
        vpc_id = string
        tags = map(string)
    }))
    default = {}
}

##############################
## NAT Gateway Variables ##
##############################

variable "nat_gateways" {
    type = map(object({
        nat_gateway_name = string
        eip_allocation_id = string
        subnet_id = string
        tags = map(string)
    }))
    default = {}
}


