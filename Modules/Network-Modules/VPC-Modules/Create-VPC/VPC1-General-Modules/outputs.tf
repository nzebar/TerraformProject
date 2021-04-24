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

##############################
## DHCP Options Set Outputs ##
##############################




