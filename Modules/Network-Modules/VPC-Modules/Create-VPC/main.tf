#########
## VPC ##
#########

resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.tags,
    var.vpc_tags,
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = var.create_vpc && length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0

  vpc_id = aws_vpc.this[0].id

  cidr_block = element(var.secondary_cidr_blocks, count.index)
}

######################
## DHCP Options Set ##
######################

resource "aws_vpc_dhcp_options" "this" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  domain_name          = var.dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = merge(
    {
      "Name" = format("%s", var.dhcp_options_set_name)
    },
    var.tags,
    var.dhcp_options_tags,
  )
}

resource "aws_vpc_dhcp_options_association" "this" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  vpc_id          = aws_vpc.this[0].id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}

######################
## Internet Gateway ##
######################

resource "aws_internet_gateway" "this" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = format("%s", var.igw_name)
    },
    var.tags,
    var.igw_tags,
  )
}

##################################
## Egress Only Internet Gateway ##
##################################

resource "aws_egress_only_internet_gateway" "this" {
  count = var.create_vpc && var.create_egress_only_igw && var.enable_ipv6 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = format("%s", var.egress_only_igw_name)
    },
    var.tags,
    var.egress_igw_tags,
  )
}

###################
## Default route ##
###################

resource "aws_default_route_table" "default" {
  count = var.create_vpc && var.manage_default_route_table ? 1 : 0

  default_route_table_id = aws_vpc.this[0].default_route_table_id
  propagating_vgws       = var.default_route_table_propagating_vgws

  dynamic "route" {
    for_each = var.default_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    { "Name" = var.default_route_table_name },
    var.tags,
    var.default_route_table_tags,
  )
}

###################
## Publiс routes ##
###################
resource "aws_route_table" "public" {
  count = var.create_vpc && var.manage_public_route_table == 1 ? 1 : 0

  vpc_id = aws_vpc.this[0].id
  propagating_vgws       = var.public_route_table_propagating_vgws

  dynamic "route" {
    for_each = var.public_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      "Name" = var.public_route_table_name
    },
    var.tags,
    var.public_route_table_tags,
  )
}

####################
## Private routes ##
####################
resource "aws_route_table" "private" {
  count = var.create_vpc && var.manage_private_route_table == 1 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  dynamic "route" {
    for_each = var.private_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      "Name" = var.private_route_table_name
    },
    var.tags,
    var.private_route_table_tags,
  )
}

####################
## Database routes ##
####################
resource "aws_route_table" "database" {
  count = var.create_vpc && var.manage_database_route_table == 1 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  dynamic "route" {
    for_each = var.database_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      "Name" = var.database_route_table_name
    },
    var.tags,
    var.database_route_table_tags,
  )
}

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


###################
## Public subnet ##
###################

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.this[0].id
  for_each = var.public_subnets 

  cidr_block = element(lookup(var.public_subnets[each.key], "cidr_block", [""]), 0)

  availability_zone = element(lookup(var.public_subnets[each.key], "availability_zone", [""]), 0)

  customer_owned_ipv4_pool = element(lookup(var.public_subnets[each.key], "customer_owned_ipv4_pool", [""]), 0)

  assign_ipv6_address_on_creation = tobool(element(lookup(var.public_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0))

  ipv6_cidr_block = tobool(element(lookup(var.public_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0)) == true ? element(lookup(var.public_subnets[each.key], "ipv6_cidr_block", [""]), 0) : null

  map_customer_owned_ip_on_launch = element(lookup(var.public_subnets[each.key], "map_customer_owned_ip_on_launch", [""]), 0) 

  map_public_ip_on_launch = tobool(element(lookup(var.public_subnets[each.key], "map_public_ip_on_launch", ["false"]), 0))

  outpost_arn = element(lookup(var.public_subnets[each.key], "outpost_arn", [""]), 0)

  tags = merge(
    {
      "Name" = element(lookup(var.public_subnets[each.key], "public_subnet_name", [""]), 0)
    },
    var.tags,
    element(lookup(var.public_subnets[each.key], "tags", {}), 0 ),
  )
}

resource "aws_route_table_association" "public_subent_route_table_association" {
  for_each =  var.public_subnets 

  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = element(lookup(var.public_subnets[each.key], "public_route_table_association", ["thx"]), 0)

  depends_on = [aws_subnet.public_subnets]
}

#####################
## Private subnets ##
#####################

resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.this[0].id
  for_each = var.private_subnets 

  cidr_block = element(lookup(var.private_subnets[each.key], "cidr_block", [""]), 0)

  availability_zone = element(lookup(var.private_subnets[each.key], "availability_zone", [""]), 0)

  customer_owned_ipv4_pool = element(lookup(var.private_subnets[each.key], "customer_owned_ipv4_pool", [""]), 0)

  assign_ipv6_address_on_creation = tobool(element(lookup(var.private_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0))

  ipv6_cidr_block = tobool(element(lookup(var.private_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0)) == true ? element(lookup(var.public_subnets[each.key], "ipv6_cidr_block", [""]), 0) : null

  map_customer_owned_ip_on_launch = element(lookup(var.private_subnets[each.key], "map_customer_owned_ip_on_launch", [""]), 0) 

  map_public_ip_on_launch = tobool(element(lookup(var.private_subnets[each.key], "map_public_ip_on_launch", ["false"]), 0))

  outpost_arn = element(lookup(var.private_subnets[each.key], "outpost_arn", [""]), 0)

  tags = merge(
    {
      "Name" = element(lookup(var.private_subnets[each.key], "private_subnet_name", [""]), 0)
    },
    var.tags,
    element(lookup(var.private_subnets[each.key], "tags", {}), 0 ),
  )
}

resource "aws_route_table_association" "private_subent_route_table_association" {
  for_each =  var.private_subnets 

  subnet_id      = aws_subnet.private_subnets[each.key].id
  route_table_id = element(lookup(var.private_subnets[each.key], "public_route_table_association", ["thx"]), 0)

  depends_on = [aws_subnet.private_subnets]
}

#####################
## Database subnets ##
#####################

resource "aws_subnet" "database_subnets" {
  vpc_id = aws_vpc.this[0].id
  for_each = var.database_subnets 

  cidr_block = element(lookup(var.database_subnets[each.key], "cidr_block", [""]), 0)

  availability_zone = element(lookup(var.database_subnets[each.key], "availability_zone", [""]), 0)

  customer_owned_ipv4_pool = element(lookup(var.database_subnets[each.key], "customer_owned_ipv4_pool", [""]), 0)

  assign_ipv6_address_on_creation = tobool(element(lookup(var.database_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0))

  ipv6_cidr_block = tobool(element(lookup(var.database_subnets[each.key], "assign_ipv6_address_on_creation", ["false"]), 0)) == true ? element(lookup(var.public_subnets[each.key], "ipv6_cidr_block", [""]), 0) : null

  map_customer_owned_ip_on_launch = element(lookup(var.database_subnets[each.key], "map_customer_owned_ip_on_launch", [""]), 0) 

  map_public_ip_on_launch = tobool(element(lookup(var.database_subnets[each.key], "map_public_ip_on_launch", ["false"]), 0))

  outpost_arn = element(lookup(var.database_subnets[each.key], "outpost_arn", [""]), 0)

  tags = merge(
    {
      "Name" = element(lookup(var.database_subnets[each.key], "database_subnet_name", [""]), 0)
    },
    var.tags,
    element(lookup(var.database_subnets[each.key], "tags", {}), 0 ),
  )
}

resource "aws_route_table_association" "database_subent_route_table_association" {
  for_each =  var.database_subnets 

  subnet_id      = aws_subnet.database_subnets[each.key].id
  route_table_id = element(lookup(var.database_subnets[each.key], "public_route_table_association", ["thx"]), 0)

  depends_on = [aws_subnet.database_subnets]
}