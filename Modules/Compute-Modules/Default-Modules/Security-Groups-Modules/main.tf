resource "aws_security_group" "public_security_group" {
for_each = var.public_security_groups

  name        = lookup(var.public_security_groups[each.key], "name", "" )
  description = lookup(var.public_security_groups[each.key], "description", "" )
  vpc_id      = lookup(var.public_security_groups[each.key], "vpc_id", "" )

  dynamic "ingress" {
    for_each = lookup(var.public_security_groups[each.key], "ingress_rules", {} )
    content {
    description      = lookup(ingress.value, "description", null )
    from_port        = lookup(ingress.value, "from_port", null )
    to_port          = lookup(ingress.value, "to_port", null )
    protocol         = lookup(ingress.value, "protocol", null )
    cidr_blocks      = lookup(ingress.value, "cidr_blocks", null )
    ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null )
    }
  }

  dynamic "egress" {
    for_each = lookup(var.public_security_groups[each.key], "egress_rules", {} )
    content {
    description = lookup(egress.value, "description", null )
    from_port        = lookup(egress.value, "from_port", null )
    to_port          = lookup(egress.value, "to_port", null )
    protocol         = lookup(egress.value, "protocol", null )
    cidr_blocks      = lookup(egress.value, "cidr_blocks", null )
    ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null )
    }
  }

  tags = lookup(var.public_security_groups[each.key], "tags", {} )
}

resource "aws_security_group" "private_security_group" {
for_each = var.private_security_groups

  name        = lookup(var.private_security_groups[each.key], "name", "" )
  description = lookup(var.private_security_groups[each.key], "description", "" )
  vpc_id      = lookup(var.private_security_groups[each.key], "vpc_id", "" )

  dynamic "ingress" {
    for_each = lookup(var.private_security_groups[each.key], "ingress_rules", {} )
    content {
    description      = lookup(ingress.value, "description", null )
    from_port        = lookup(ingress.value, "from_port", null )
    to_port          = lookup(ingress.value, "to_port", null )
    protocol         = lookup(ingress.value, "protocol", null )
    cidr_blocks      = lookup(ingress.value, "cidr_blocks", null )
    ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null )
    }
  }

  dynamic "egress" {
    for_each = lookup(var.private_security_groups[each.key], "egress_rules", {} )
    content {
    description = lookup(egress.value, "description", null )
    from_port        = lookup(egress.value, "from_port", null )
    to_port          = lookup(egress.value, "to_port", null )
    protocol         = lookup(egress.value, "protocol", null )
    cidr_blocks      = lookup(egress.value, "cidr_blocks", null )
    ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null )
    }
  }

  tags = lookup(var.private_security_groups[each.key], "tags", {} )
}

resource "aws_security_group" "database_security_group" {
for_each = var.database_security_groups

  name        = lookup(var.database_security_groups[each.key], "name", "" )
  description = lookup(var.database_security_groups[each.key], "description", "" )
  vpc_id      = lookup(var.database_security_groups[each.key], "vpc_id", "" )

  dynamic "ingress" {
    for_each = lookup(var.database_security_groups[each.key], "ingress_rules", {} )
    content {
    description      = lookup(ingress.value, "description", null )
    from_port        = lookup(ingress.value, "from_port", null )
    to_port          = lookup(ingress.value, "to_port", null )
    protocol         = lookup(ingress.value, "protocol", null )
    cidr_blocks      = lookup(ingress.value, "cidr_blocks", null )
    ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null )
    }
  }

  dynamic "egress" {
    for_each = lookup(var.database_security_groups[each.key], "egress_rules", {} )
    content {
    description = lookup(egress.value, "description", null )
    from_port        = lookup(egress.value, "from_port", null )
    to_port          = lookup(egress.value, "to_port", null )
    protocol         = lookup(egress.value, "protocol", null )
    cidr_blocks      = lookup(egress.value, "cidr_blocks", null )
    ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null )
    }
  }

  tags = lookup(var.database_security_groups[each.key], "tags", {} )
}