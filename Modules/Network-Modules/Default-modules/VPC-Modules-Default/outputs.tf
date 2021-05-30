#################
## VPC Outputs ##
#################

output "vpc" {
    value = aws_vpc.vpc[0]
}

output "vpc_default_route_table_id" {
    value = aws_vpc.vpc[0].default_route_table_id
}

output "vpc_tags" {
    value = aws_vpc.vpc[0].tags
}

output "enable_ipv6" {
    value = aws_vpc.vpc[0].assign_generated_ipv6_cidr_block
}

##############################
## DHCP Options Set Outputs ##
##############################

output "dhcp_options_domain_name" {
    value = var.enable_dhcp_options == true ? aws_vpc_dhcp_options.this[0].domain_name : null
}





