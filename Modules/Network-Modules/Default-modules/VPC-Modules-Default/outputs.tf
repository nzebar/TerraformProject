#################
## VPC Outputs ##
#################

output "vpc" {
    value = aws_vpc.vpc1[0]
}

output "vpc_default_route_table_id" {
    value = aws_vpc.vpc1[0]
}

output "vpc_tags" {
    value = aws_vpc.vpc1[0].tags
}

output "enable_ipv6" {
    value = aws_vpc.vpc1[0].assign_generated_ipv6_cidr_block
}

###############################
## VPC: Secondary CIDR Block ##
###############################

output "sub_cidr_assoc" {
    value = aws_vpc_ipv4_cidr_block_association.this
}

##############################
## DHCP Options Set Outputs ##
##############################

output "dhcp_options" {
    value = aws_vpc_dhcp_options.this[0]
}

##############################
## DHCP Options Set Outputs ##
##############################

output "dhcp_options_set_assoc" {
    value = aws_vpc_dhcp_options_association.this
}



