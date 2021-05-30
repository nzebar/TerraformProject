##############################
## Default Routes Variables ##
##############################

variable "manage_default_route_table" {
    type = bool
    default = false
}

variable "default_route_table_id" {
    type = string
    default = null
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

variable "route_tables" {
    type = map(object({
        route_table_name = string
        vpc_id = string
        propagating_vgws = list(string)
        associated_routes = map(map(string))
        tags = map(string)
    }))
    default = null
}


