#########################
## Default route table ##
#########################

resource "aws_default_route_table" "default" {
  count = var.manage_default_route_table ? 1 : 0

  default_route_table_id = var.default_route_table_id
  propagating_vgws       = var.default_route_table_propagating_vgws == [] ? null : var.default_route_table_propagating_vgws 

  dynamic "route" {
    for_each = var.default_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null )
      destination_prefix_list_id = lookup(route.value, "destination_prefix_list_id", null )

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
    var.default_route_table_tags,
  )
}

##################
## Route Tables ##
##################
resource "aws_route_table" "route_tables" {
  for_each = var.route_tables

  vpc_id = each.value.vpc_id
  propagating_vgws = each.value.propagating_vgws

  dynamic "route" {
    for_each = each.value.associated_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = lookup(route.value, "cidr_block", null)
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
      destination_prefix_list_id = lookup(route.value, "destination_prefix_list_id", null)

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
      "Name" = each.value.route_table_name
    },
    each.value.tags
  )
}