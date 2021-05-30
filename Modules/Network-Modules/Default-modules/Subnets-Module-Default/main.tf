########################
## Availability Zones ##
########################

data "aws_availability_zones" "available" {
  all_availability_zones = var.include_all_availability_zones == true ? var.include_all_availability_zones : false
  state = var.include_all_availability_zones != true ? var.filter_az_by_state : null

  dynamic "filter"{
    for_each = var.include_all_availability_zones != true ? var.filter_az_by_name_value : {}
    content  {
      name = each.key
      values = each.value
    } 
  } 

  exclude_names = var.include_all_availability_zones != true ? var.excluded_zone_names : []
  exclude_zone_ids = var.include_all_availability_zones != true ? var.excluded_zone_ids : []

}


############
## Subnet ##
############

resource "aws_subnet" "subnets" {
  for_each = var.subnets 

  vpc_id = each.value.vpc_id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  customer_owned_ipv4_pool = each.value.customer_owned_ipv4_pool
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  ipv6_cidr_block = each.value.ipv6_cidr_block == "" ? null : each.value.ipv6_cidr_block
  map_customer_owned_ip_on_launch = each.value.map_customer_owned_ip_on_launch
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  outpost_arn = each.value.outpost_arn
  tags = merge(
    {
      "Name" = each.value.subnet_name
    },
    each.value.tags,
  )
}

#####################################
## Public Route Table Associations ##
#####################################

resource "aws_route_table_association" "route_table_associations" {
for_each = var.subnets

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = each.value.route_table_association
}

