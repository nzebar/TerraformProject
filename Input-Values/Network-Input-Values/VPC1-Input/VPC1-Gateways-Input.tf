module "VPC1_Gateways" {
  source = "../../../Modules/Network-Modules/VPC-Modules/Create-VPC/VPC1-Gateways-Module"

#############################
## Internet Gateway Config ##
#############################
#Ref lines 62 - 78 of main.tf file.
internet_gateways = {

    igw1 = {
        "vpc_id" = [module.VPC1.vpc.id] #default
        "igw_name" = ["VPC1-igw1"]
        "igw_tags" = [{
            "VPC1" = "igw"
        }]

    }

}

##########################################
## Egress Only Internet Gateway Config. ##
##########################################
# Ref lines 80 - 96 of main.tf file.
egress_internet_gateways = {
# assign_generated_ipv6_cidr_block in VPC1 module must = true

    egress_gw1 = {
        "vpc_id" = [module.VPC1.vpc.id]
        "egress_igw_name" = ["egressIGW"] 
        "egress_igw_tags" = [{
            "egress" = "igw"
        }]
    }

}

##################
## NAT Gateways ##
##################

nat_gateways = {

    natGW-usEast1a = {
        "nat_gateway_name" = ["natGW-usEast1a"]
        "eip_allocation_id" = [module.VPC1_Gateways.internet_gateway_igw1.id]
        "subnet_id" = [module.VPC1_Subnets.aws_subnet_public_subnets_subnet1.id]
        
        }

    natGW-usEast1b = {
        "nat_gateway_name" = ["natGW-usEast1b"]
        "eip_allocation_id" = [module.VPC1_Gateways.internet_gateway_igw1.id]
        "subnet_id" = [module.VPC1_Subnets.aws_subnet_public_subnets_subnet2.id]
        }
    }

}