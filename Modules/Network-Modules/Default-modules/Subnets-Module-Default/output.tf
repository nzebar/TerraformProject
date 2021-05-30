################################
## Availability Zones Outputs ##
################################

output "aws_availability_zones_available_names" {
    value = data.aws_availability_zones.available.names
}

output "aws_availability_zones_available_zone_ids" {
    value = data.aws_availability_zones.available.zone_ids
}

###########################
## Public subnet Outputs ##
###########################

output "public_subnet_1" {
    value = aws_subnet.subnets["public_subnet_1"]
}

output "public_subnet_2" {
    value = aws_subnet.subnets["public_subnet_2"]
}

############################
## Private subnet Outputs ##
############################

output "private_subnet_1" {
    value = aws_subnet.subnets["private_subnet_1"]
}

output "private_subnet_2" {
    value = aws_subnet.subnets["private_subnet_2"]
}

#############################
## Database subnet Outputs ##
#############################

output "database_subnet_1" {
    value = aws_subnet.subnets["database_subnet_1"]
}

output "database_subnet_2" {
    value = aws_subnet.subnets["database_subnet_2"]
}

output "database_subnet_3" {
    value = aws_subnet.subnets["database_subnet_3"]
}


