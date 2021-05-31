
######################
## Internet Gateway ##
######################

resource "aws_internet_gateway" "this" {
  for_each = var.internet_gateways

  vpc_id = each.value.vpc_id

  tags = merge(
    {
      "Name" = each.value.igw_name
    },
     each.value.tags,
    
  )
}

##################################
## Egress Only Internet Gateway ##
##################################

resource "aws_egress_only_internet_gateway" "this" {
  for_each = var.egress_internet_gateways

  vpc_id = each.value.vpc_id

  tags = merge(
    {
      "Name" = each.value.egress_igw_name
    },
    each.value.tags,
  )
}

##################
## NAT Gateways ##
##################

resource "aws_nat_gateway" "nat_gateway" {
  for_each = var.nat_gateways 

  allocation_id = each.value.eip_allocation_id
  subnet_id     = each.value.subnet_id 

  tags = merge( 
  { Name = each.value.nat_gateway_name}, 
  each.value.tags,
  )
}



