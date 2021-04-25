module "VPC1_ROUTE_TABLES" {
    source = "../../../Modules/Network-Modules/Default-modules/Route-Table-Modules-Default"

#################################
## Default Route Table Config. ##
#################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
# Ref lines 98 - 132 of main.tf file.

    manage_default_route_table = true
    default_route_table_id = module.VPC_VPC1.vpc_default_route_table_id.default_route_table_id
    default_route_table_propagating_vgws = [] 
    default_route_table_routes = {}

    default_route_table_name = "dummy default"
    default_route_table_tags = {
        "hey" = "yo"
    }


################################
## Public Route Table Config. ##
################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Ref lines 134 - 170 of main.tf file.

    Public_Route_Tables = {

        RouteTable1 = {
            public_route_table_name = "PublicRouteTable"
            "vpc_id_for_public_route_table" = module.VPC_VPC1.vpc.id
            "propagating_vgws_for_public_route_table" = []

            associated_routes = {
                Pubroute1 =  {
                    cidr_block = "192.168.0.0/16"
                    "gateway_id"     = module.GATEWAYS_VPC1.internet_gateway_igw1.id
                }
        }

        public_route_table_tags = {
            "public" = "table"
        }
    }

        RouteTable2 = {
            public_route_table_name = "PrivateRouteTable"
            "vpc_id_for_public_route_table" = module.VPC_VPC1.vpc.id
            "propagating_vgws_for_public_route_table" = []

            associated_routes = {
                Pubroute1 =  {
                        cidr_block = "192.168.0.0/16"
                        "gateway_id" = module.GATEWAYS_VPC1.internet_gateway_igw1.id
                    }
            }

            public_route_table_tags = {
                "public" = "table"
        }
    }
}

#################################
## Private Route Table Config. ##
#################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Ref lines 172 - 208 of main.tf file.

    Private_Route_Tables = {

        RouteTable1 = {
            private_route_table_name = "PublicRouteTable"
            "vpc_id_for_private_route_table" = module.VPC_VPC1.vpc.id
            "propagating_vgws_for_private_route_table" = []

            associated_routes = {

                Privroute1 =  {
                        cidr_block = "192.168.0.0/16"
                        nat_gateway = module.GATEWAYS_VPC1.nat_gateway_id_useast1a.id
                    }

                Privroute2 =  {
                        cidr_block = "192.168.0.0/16"
                        nat_gateway = module.GATEWAYS_VPC1.nat_gateway_id_useast1b.id
                    }
                }

            private_route_table_tags = {
                "public" = "table"
            }
        }

        RouteTable2 = {
            public_route_table_name = "PrivateRouteTable"
            "vpc_id_for_private_route_table" = module.VPC_VPC1.vpc.id
            "propagating_vgws_for_private_route_table" = []

            associated_routes = {
                Privroute1 =  {
                        cidr_block = "192.168.0.0/16"
                        nat_gateway = module.GATEWAYS_VPC1.nat_gateway_id_useast1a.id
                    }
                Privroute2 =  {
                        cidr_block = "192.168.0.0/16"
                        nat_gateway = module.GATEWAYS_VPC1.nat_gateway_id_useast1b.id
                    }
                }

            private_route_table_tags = {
                "private" = "table"
            }
        }
    }

##################################
## Database Route Table Config. ##
##################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# Ref lines 209 - 244 of main.tf file.

    Database_Route_Tables = {

        RouteTable1 = {
            datatabase_route_table_name = "PublicRouteTable"
            "vpc_id_for_database_route_table" = module.VPC_VPC1.vpc.id
            "propagating_vgws_for_database_route_table" = []

            associated_routes = {
            }

            database_route_table_tags = {
                "public" = "table"
                }
            }
        

        RouteTable2 = {
            datatabase_route_table_name = "PublicRouteTable"
            "vpc_id_for_database_route_table" = module.VPC_VPC1.vpc.id
            "propagating_vgws_for_database_route_table" = []

            associated_routes = {
            }

            database_route_table_tags = {
                "public" = "table"
                }
            }   

        RouteTable3 = {
            datatabase_route_table_name = "PublicRouteTable"
            "vpc_id_for_database_route_table" = module.VPC_VPC1.vpc.id
            "propagating_vgws_for_database_route_table" = []

            associated_routes = {
            }

            database_route_table_tags = {
                "public" = "table"
            }
        }
    }
  
}