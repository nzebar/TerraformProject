###########################
## Route53: Hosted Zones ##
###########################

resource "aws_route53_zone" "this" {
  for_each = var.Hosted_Zones

  name          = lookup(var.Hosted_Zones[each.key], "name", null)
  comment       = lookup(var.Hosted_Zones[each.key], "comment", null)
  force_destroy = lookup(var.Hosted_Zones[each.key], "force_destroy", false)
  delegation_set_id = lookup(var.Hosted_Zones[each.key], "delegation_set_id", false) == "" ? null : lookup(var.Hosted_Zones[each.key], "delegation_set_id", false)

  dynamic "vpc" {
    for_each = try(tolist(lookup(var.Hosted_Zones[each.key], "regions", [])), [lookup(var.Hosted_Zones[each.key], "regions", {})])

    content {
      vpc_id     = lookup(vpc.value, "vpc_id", null)
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = merge(
    lookup(var.Hosted_Zones[each.key], "tags", {}),
  )
}

###########################
## Route53: Zone Records ##
###########################

locals {
  # convert from list to map with unique keys
  recordsets = { for rs in var.records : join(" ", compact(["${rs.name} ${rs.type}", lookup(rs, "set_identifier", "")])) => rs }
}

data "aws_route53_zone" "this" {
  zone_id      = var.zone_id
  name         = var.zone_name
  private_zone = var.private_zone

  depends_on = [aws_route53_zone.this]
}

resource "aws_route53_record" "this" {
  for_each = local.recordsets 

  zone_id = data.aws_route53_zone.this.zone_id  

  name            = each.value.name != "" ? "${each.value.name}.${data.aws_route53_zone.this.name}" : data.aws_route53_zone.this.name
  type            = each.value.type
  ttl             = lookup(each.value, "ttl", "") == "" ? null : lookup(each.value, "ttl", null) 
  records         = lookup(each.value, "records", [])
  set_identifier  = lookup(each.value, "set_identifier", "")
  health_check_id = lookup(each.value, "health_check_id", "")

  dynamic "alias" {
    for_each = length(keys(lookup(each.value, "alias", {}))) == true ? lookup(each.value, "alias", {}) : {}

    content {
      name                   = each.value.alias.name
      zone_id                = try(each.value.alias.zone_id, data.aws_route53_zone.this.zone_id)
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false)
    }
  }

  dynamic "failover_routing_policy" {
    for_each = length(keys(lookup(each.value, "failover_routing_policy", {}))) == true ? lookup(each.value, "failover_routing_policy", {}): {}

    content {
      type = each.value.failover_routing_policy.type
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = length(keys(lookup(each.value, "weighted_routing_policy", {}))) == true ? lookup(each.value, "weighted_routing_policy", {}) : {}

    content {
      weight = each.value.weighted_routing_policy.weight
    }
  }

   dynamic "latency_routing_policy" {
    for_each = length(keys(lookup(each.value, "latency_routing_policy", {}))) == true ? lookup(each.value, "latency_routing_policy", {}) : {}

    content {
      region = each.value.geolocation_routing_policy.region
    }
   }

}
