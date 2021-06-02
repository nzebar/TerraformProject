##################
## VPC Overview ##
##################
[VPC Resource Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)

Allows you to create a vpc in the desired AWS account.
Use the following example to use as reference for inputing values to create a VPC
Example:

```t
    create_vpc = bool # Whether or not to create the VPC
    vpc_name = string # VPC name to be mreged with the tags below
    cidr_block       = string # CIDR block for the VPC
    assign_generated_ipv6_cidr_block = string # Whether or not to assign IPv6 CIDR block to the VPC
    instance_tenancy = string # "default" || "dedicated". Unless big $$$, use default
    enable_dns_support = bool # If DNS resolution is supported. If true DNS servers are @ 169.254.169.253 || base VPC CIDR Block + 2
    enable_dns_hostnames = bool # automaticaly assigns resolvable public DNS hostnames to Public IP addresses
    enable_classiclink = bool # Whether or not allow the creation of a classic link for EC2 classic instances
    enable_classiclink_dns_support = bool # Whether to enable classic link dns support
    
    vpc_tags = {
        "Key" = "Value" # Tags for the VPC
    }
```

#########################################
## VPC: Associated CIDR Block Overview ##
#########################################
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association

Allows you to associate extra CIDR block for the newly created VPC.
Use the example below as reference:

    associate_cidr_blocks = bool <- Whether or not to associate the CIDR blocks below with the VPC
    cidr_blocks_associated = [""] <- The CIDR blocks to associate with the VPC

###############################
## DHCP Options Set Overview ##
###############################
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options

Allows you to create a DHCP options set for the VPC.
Use the example below as reference:

    enable_dhcp_options = bool <- Whether or not to create a DHCP options set for the VPC
    dhcp_options_set_name = "" <- Name of DHCP options set to be merged with the tags below
    dhcp_options_domain_name = ".com" <- Valid domain name for the DHCP options set
    dhcp_options_domain_name_servers = [""] <- DNS servers to use for DHCP options set
    dhcp_options_ntp_servers = [""] <- NTP servers to use for DHCP Options set
    dhcp_options_netbios_name_servers = [""] <- netbios name servers to be used for the dhcp options set
    dhcp_options_netbios_node_type = number <- Netbios node type to be used for the dhcp options set

    dhcp_options_tags = {
        "Key" = "Value" <- Tags to associate with the DHCP options set
    }

################################################
## Default Route Table / Route Table Overview ##
################################################
Resource Reference:
- Default Route Table: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
- Route Table: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

## Default Route Table ##

Allows you to create a default route table. 
Use the following example to create a default route table for the VPC:

        manage_default_route_table = bool <- Whether or not to create a default route table.
        default_route_table_name = "" <- To be merged with tags below
        default_route_table_id = "" <- The VPC default route table id to be used
        default_route_table_propagating_vgws = [""] <- List of virtual gateways for propogation
        default_route_table_routes = { <- Mapping of map(string) to declare routes
            route_example = {
                DestinationArgumnet = DestinationValue
                TargetArgument = TargetValue
            }
        }

        default_route_table_tags = {
            "Key" = "Value" <- Tags to associate with the default route table
        }

## Route_Tables ##

route_tables = {

# Allows you to create multiple instances of route tables to deploy.
# Use the following reference to specify a route table to be provisiioned:

        Example_Route_Table = {
            ## ROUTE TABLE SETTIINGS ##
            route_table_name = "" <- Name of the Route Table to be merged with the tags below
            vpc_id = "" <- VPC ID to place the route table in
            propagating_vgws = [""] <- Specify virtual gateways for automatic routing to VPN connections

            ## ASSOCIATED ROUTES ##
            associated_routes = {
                Route_1 =  {
                    DestinationArgumnet = DestinationValue
                    TargetArgument = TargetValue
                    }
            }

            ## ROUTE TABLE TAGS ##
            tags = {
                "Key" = "Value" <- Tags to associate with the route table
                }
        }
}

    ## Notes: 
        - When specifyiing TargetArguments in the "associated routes" map. Use the KEY from one of the desired entries in the TARGET ROUTES section below to use for a TargetArgument.
        - If specifying, network interface or instance as a TargetArgument, input the id of the desired TargetArgument using traditonal ways of referencing resource: module output || direct resource ref || direct id input
        - You are able to create multiple instances of route tables, just copy and paste the format for desired number of times.
        - Keys for route tables must be unique or else Terraform will process only one route table instance if there are duplicates.
        - Use the following format to output specific attributes for a given route table instance:

            output "output_value_name" {
                value = aws_route_table.route_tables["route_table_key"].attribute
            }

#################################
## Destination Routes Overview ##
#################################

## VPC Peering Connection ##
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection

vpc_peering_connections = {

# Allows you to create as many VPC peering connections as desired.
# Use the follwoing example to as a reference:

    peering_connection_1 = {
            peer_owner_id = "" <- The AWS account ID of the owner for which the peering connection will connect with
            peer_vpc_id = "" <- ID of the VPC for which you will be creating the peering connection with
            vpc_id = "" <- The ID of this VPC
            auto_accept = bool <- Auto accept peering connection. **Both VPCs must be in the same account for this to be true
            peer_region = bool <- The region for which the VPC resides in
            acceptor = {
                allow_remote_vpc_dns_resolution = bool <- Allow public to private DNS resolution in the peering connection
                allow_classic_link_to_remote_vpc = bool <- Allows outbound communication from local ClassicLink to the remote VPC
                allow_vpc_to_remote_classic_link = bool <- Allows for outbound communication from the local VPC to the remote ClassicLink connection
            }
            requester = {
                allow_remote_vpc_dns_resolution = bool <- Allow public to private DNS resolution in the peering connection
                allow_classic_link_to_remote_vpc = bool <- Allows outbound communication from local ClassicLink to the remote VPC
                allow_vpc_to_remote_classic_link = bool <- Allows for outbound communication from the local VPC to the remote ClassicLink connection
            }
            tags = { 
                "key" = "value" <- Tags to be assocaited with the VPC peering connection
            }
        }

}
 
## Internet Gateway ##
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

internet_gateways = {

# Allows you to create as many Internet Gateways as desired.
# Use the follwoing example to as a reference:

    Example_Internet_Gateway = {
            igw_name = "" <- IGW name to be merged with the tags below

            vpc_id = "" <- VPC ID for where the IGW will reside in

            tags = {
                "Key" = "Value" <- Tags to associate with the IGW
            }
        }
    
}

## Egress Only Internet Gateways ##
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway

egress_internet_gateways = {

# Allows you to create as many Egress Only Internet Gateways as desired.
# Use the follwoing example to as a reference:

    Example_Egress_Only_Internet_Gateway = {
            egress_igw_name = "Example_Name" <- Egress only IGW name to be merged with the tags below

            vpc_id = "" <- VPC ID for where the Egress only IGW will reside in
            
            tags = {
                "Key = "Value" <- Tags to associate with the Egress only IGW
            }
        }

}

## NAT Gateways ##
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway

nat_gateways = {

# Allows you to create as many NAT Gateways as desired.
# Use the follwoing example to as a reference:

     Example_NAT_Gateway = {
            nat_gateway_name = "" <- Name of NAT Gateway to be merged with the tags below
            subnet_id =  "" <- Key of created subnet from section below to associate NAT gateway with. ** Use a Public Subnet 
            create_new_eip = bool <- Whether or not to create and associate a new EIP with the NAT Gateway
            new_eip_index = number <- Index number of the newly created EIP. See Note below for me clarification...
            eip_allocation_id = "" <- Specify the ID of an existing EIP to associate with the NAT Gateway. create_new_eip must == false
            
            tags = { "Key" = "Value" } <- Tags to associate with the NAT Gateway
            }

}

    Notes:
        new_eip_index - A list of new EIPs is created base upon the number of NAT gateways that specified true for creating a new EIP.
                        The index number tells Terraform which EIP amongst that list to associate with each NAT Gateway.
                        ** Index starts from 0 not 1!
                        Example:

                        Example_NAT_Gateway_1 = {
                            nat_gateway_name = "" 
                            subnet_id =  ""  
                            create_new_eip = true 
                            new_eip_index = 0 
                            eip_allocation_id = ""
                            
                            tags = { "Key" = "Value" } 
                            }

                        Example_NAT_Gateway_2 = {
                            nat_gateway_name = "" 
                            subnet_id =  ""  
                            create_new_eip = false 
                            new_eip_index = null 
                            eip_allocation_id = "Some EIP allocation ID"
                            
                            tags = { "Key" = "Value" } 
                            }
                        Example_NAT_Gateway_3 = {
                            nat_gateway_name = "" 
                            subnet_id =  ""  
                            create_new_eip = true 
                            new_eip_index = 1 
                            eip_allocation_id = ""
                            
                            tags = { "Key" = "Value" } 
                            }

                        ** Since there are two NAT Gateway instances that are creating a new EIP "Example_NAT_Gateway_1" will receive the first new EIP. "Example_NAT_Gateway_2" will receive the second new EIP

## VPC Endpoints ##
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint

vpc_endpoints = {

# Allows you to create as many VPC Endpoints as desired.
# Use the follwoing example to as a reference:

        Example_VPC_Endpoint = {
            vpc_endpoint_type = "" <- Type of VPC Endpoint
            service_name = "" <- Service name for the VPC Endpoint
            vpc_id = "" <- VPC ID for where the endpoint will reside in
            auto_accept = bool <- Whether or not to auto accept the VPC endpoint. Endpoint & Endpoint Service must be in the same account
            policy = "" <- Permissions policy to attach to the VPC endpoint. Type must == Interface || Gateway
            private_dns_enabled = true <- Whether or not assocaite a private hosted zone with the specified VPC. Type must == Interface
            route_table_ids = [] <- One ore more route table IDs to associate with the endpoint. Type must == Gateway
            subnet_ids = [] <- One or more Subnet IDs to associate with the endpoint. Type must == GatewayLoadBalancer || Interface
            security_group_ids = [] <- One ore security groups to assocaite with the endpoint. Type muss == Interface

            tags = {
                "key" = "value" <- Tags to associate with the VPC Endpoint.
            }
        }

}

## Transit Gateways ##
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway

transit_gateways = {

# Allows you to create as many Transit Gateways as desired.
# Use the follwoing example to as a reference:

        Example_Transit_Gateway = {
            description = "" <- Description of Transit Gateway
            amazon_side_asn = number <- ASN for the Amazon side BGP session.  
            auto_accept_shared_attachments = "" <- Whether resource attachment requests are automatically accepted
            default_route_table_association = "" <- Whether resource attachments are automatically assocaited with the default route table
            default_route_table_propagation = "" <- Whether resoure attachments automatically propagate routes to the default propagation route table
            dns_support = "" <- Whether DNS support is enabled or not
            vpn_ecmp_support = "" <- Whether VPN Equal Cost Multipath Protocol support is enabled

            tags = {
                "key" = "value" <- Tags to associate with the Transit Gateway
            }
        }
    
}

######################
## Subnets Overview ##
######################   
Resource Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

subnets = {

# Allows you to create as many Subnets as desired.
# As well, allows you to associate the subnet with a route table.
# Use the follwoing example to as a reference:

        Example_Subnet = {
            subnet_name = "" <- Name of subnet to be merged with the tags below
            vpc_id = "" <- The VPC ID for which the subnet will reside in
            cidr_block = "" <- Valid CIDR block for the subnet
            availability_zone = "" <- Availability Zone for the subnet to be located in
            customer_owned_ipv4_pool = "" <- Customer owned IPv4 address pool. Must be used with outpost_arn attribute. 
            assign_ipv6_address_on_creation = bool <- Whether interfaces provisioned in the subnet should receive an IPv6 address
            ipv6_cidr_block = "" <- The IPv6 range for the subnet. Must use at least /64 prefix length
            map_customer_owned_ip_on_launch = bool <- Whether interface in the subnet should be associated with a customer owner IPv4 address
            map_public_ip_on_launch = bool <- Whether interfaces in the subnet shoul automatically receive public IP addresses
            outpost_arn = "" <- The ARN of the outpost

            route_table_association = "" <- The route table key from route tables above to associate subnet with the route table 

            tags = {
                "Key" = "Value", <- The tags to associate with the subnet
            }
        }

}