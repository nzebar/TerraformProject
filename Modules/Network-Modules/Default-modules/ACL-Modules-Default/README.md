#########################
## Default Network ACL ##
#########################
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl

default_network_acl = {

# Allows you to create as many default ACLs for the desired VPCs
# Use the example below for a reference:

    Example_Default_Network_ACL = {
        default_network_acl_name = "" <- Name of default ACL to be merged with tags below
        default_network_acl_id = "" <- ID of default_network_acl attribute exported from the VPC resource 
        default_acl_subnet_ids = [] <- One or more subnets to associate with the default network ACL

        default_network_acl_ingress = { <- Mapping of objects for the ingress rules to associate with default network ACL

            ingress_rule_1 = { <- Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                action = "" <- Whether to "Allow" || "Deny" access to the ports and protocol below
                cidr_block = "" <- Location from where the traffic is coming from
                from_port = number <- Starting port
                icmp_code       = number <- Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                icmp_type       = number <- Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                ipv6_cidr_block = "" <- Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                protocol = "" <- Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                rule_no = number <- The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                to_port = number <- Ending port
                }
            }

        default_network_acl_egress = { <- Mapping of objects for the egress rules to associate with default network ACL

            egress_rule_1 = { <- Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                action = "" <- Whether to "Allow" || "Deny" access to the ports and protocol below
                cidr_block = "" <- Location from where the traffic is coming from
                from_port = number <- Starting port
                icmp_code       = number <- Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                icmp_type       = number <- Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                ipv6_cidr_block = "" <- Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                protocol = "" <- Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                rule_no = number <- The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                to_port = number <- Ending port
                }
            }

        tags = {
            "key" = "value" <- Tags to associate with the default ACL
        }
    }
}

#################
## Network ACl ##
#################
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl

( public || private || database )_network_acl = {

# Allows you to create as many Network ACLs for the desired VPCs
# Use the example below for a reference:
# Example is used for three identical variables: public_network_acl | private_network_acl | database_network_acl

    Example_Network_ACL = {
        public_network_acl_name = "" <- Name of ACL to be merged with tags below
        vpc_id = "" <- ID of VPC for the Network ACL to reside in
        ( public || private || database )_acl_subnet_ids = [] <- One or more Subnet IDs to associate with the network ACL 

      ( public || private || database )_network_acl_ingress = { <- Mapping of objects for the ingress rules to associate with default network ACL

            ingress_rule_1 = { <- Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                action = "" <- Whether to "Allow" || "Deny" access to the ports and protocol below
                cidr_block = "" <- Location from where the traffic is coming from
                from_port = number <- Starting port
                icmp_code       = number <- Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                icmp_type       = number <- Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                ipv6_cidr_block = "" <- Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                protocol = "" <- Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                rule_no = number <- The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                to_port = number <- Ending port
                }
            }

    ( public || private || database )_network_acl_egress = { <- Mapping of objects for the egress rules to associate with default network ACL

            egress_rule_1 = { <- Each ingress rule key must be unique. Terraform does not process duplicate keys in this case
                action = "" <- Whether to "Allow" || "Deny" access to the ports and protocol below
                cidr_block = "" <- Location from where the traffic is coming from
                from_port = number <- Starting port
                icmp_code       = number <- Specify Null for Terraform to ignore. Otherwise, the ICMP Code to use
                icmp_type       = number <- Specify Null for Terraform to ignore. Otherwise, the ICMP Type to use
                ipv6_cidr_block = "" <- Specify Null for Terraform to ignore. Otherwise, the IPv6 CIDR Block to use
                protocol = "" <- Use -1 to specify all protocol. To/From port must == 0 if protocol = -1. Otherwise, "tcp" || "udp" 
                rule_no = number <- The rule number to give the rule. Lower rule numbers give precedence over higher rule numbers
                to_port = number <- Ending port
                }
            }

        tags = {
            "key" = "value" <- Tags to associate with the Network ACL
        }
    }
}
