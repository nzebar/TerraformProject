module "GATEWAYS_VPC1" {
  source = "../../Modules/Network-Modules/Default-modules/Gateways-Module-Default"

#######################
## Internet Gateways ##
#######################
internet_gateways = {

    Internet_Gateway_1_VPC1 = {
        igw_name = "IGW_1_VPC1"

        vpc_id = module.VPC_VPC1.vpc.id

        tags = {
            "Internet_Gateways" = "IGW_1_VPC1"
        }
    }

}

###################################
## Egress Only Internet Gateways ##
###################################
egress_internet_gateways = {
# assign_generated_ipv6_cidr_block in VPC1 module must = true

    # Egress_Only_Internet_Gateway_1_VPC1 = {
    #     egress_igw_name = "EGRESS_IGW_1_VPC1"

    #     vpc_id = module.VPC_VPC1.vpc.id
         
    #     tags = {
    #         egress_only_internet_gateways = "EGRESS_IGW_1_VPC1"
    #     }
    # }

}

##################
## NAT Gateways ##
##################

nat_gateways = {

    internet_gateway_1 = {
        nat_gateway_name = "natGW-usEast1a"
        eip_allocation_id = module.GATEWAYS_VPC1.Internet_Gateway_1_VPC1.id
        subnet_id =  module.SUBNETS_VPC1.private_subnet_1.id 

        tags = {
            "internet_gateways" = "internet_gateway_1_VPC1"
            }
        }

    internet_gateway_2 = {
        nat_gateway_name = "natGW-usEast1b"
        eip_allocation_id = module.GATEWAYS_VPC1.Internet_Gateway_1_VPC1.id
        subnet_id =  module.SUBNETS_VPC1.private_subnet_2.id 

        tags = {
            "internet_gateways" = "internet_gateway_2_VPC1"
            }
        }
    }












}