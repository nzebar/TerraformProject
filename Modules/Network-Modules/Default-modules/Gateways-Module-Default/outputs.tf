##############################
## Internet Gateway Outputs ##
##############################

output "Internet_Gateway_1_VPC1" {
    value = aws_internet_gateway.this["Internet_Gateway_1_VPC1"]
}

##########################################
## Egress Only Internet Gateway Outputs ##
##########################################

# output "Egress_Only_Internet_Gateway_1_VPC1" {
#     value = aws_egress_only_internet_gateway.this["Egress_Only_Internet_Gateway_1_VPC1"]
# }

##################
## NAT Gateway Outputs ##
##################

output "nat_gateway_id_useast1a" {
    value = aws_nat_gateway.nat_gateway["internet_gateway_1"]
}

output "nat_gateway_id_useast1b" {
    value = aws_nat_gateway.nat_gateway["internet_gateway_2"]
}