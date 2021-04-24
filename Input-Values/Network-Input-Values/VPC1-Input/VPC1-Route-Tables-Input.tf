module "VPC1_Route_Table" {
    source = "../../../Modules/Network-Modules/VPC-Modules/Create-VPC/Route-Table-Modules"

#################################
## Default Route Table Config. ##
#################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table
# Ref lines 98 - 132 of main.tf file.

    manage_default_route_table = true
    default_route_table_id = module.VPC1.vpc_default_route_table_id.default_route_table_id
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

        # Each argument creates a new route table
        # Argument names must be unique.

            RouteTable1 = {
                public_route_table_name = "PublicRouteTable"
                "vpc_id_for_public_route_table" = module.VPC1.vpc.id
                "propagating_vgws_for_public_route_table" = []
                associated_routes = {
                    Pubroute1 =  {
                        cidr_block = "192.168.0.0/16"
                        "gateway_id"     = module.VPC1_Gateways.internet_gateway_igw1.id
                    }
            }

            public_route_table_tags = {
                "public" = "table"
            }
        }

            RouteTable2 = {
                public_route_table_name = "PrivateRouteTable"
                "vpc_id_for_public_route_table" = module.VPC1.vpc.id
                "propagating_vgws_for_public_route_table" = []
                associated_routes = {
                    Pubroute1 =  {
                            cidr_block = "192.168.0.0/16"
                            "gateway_id" = module.VPC1_Gateways.internet_gateway_igw1.id
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

    # Each argument creates a new route table
    # Argument names must be unique.

        RouteTable1 = {
            private_route_table_name = "PublicRouteTable"
            "vpc_id_for_private_route_table" = module.VPC1.vpc.id
            "propagating_vgws_for_private_route_table" = []
            associated_routes = {

                # Declare routes by referencing them with module outputs variables.

                Privroute1 =  {
                        cidr_block = "192.168.0.0/16"
                        nat_gateway = module.VPC1_Gateways.nat_gateway_id_useast1a.id
                    }
                Privroute2 =  {
                        cidr_block = "192.168.0.0/16"
                        nat_gateway = module.VPC1_Gateways.nat_gateway_id_useast1b.id
                    }
                }

            private_route_table_tags = {
                "public" = "table"
            }
        }

        RouteTable2 = {
            public_route_table_name = "PrivateRouteTable"
            "vpc_id_for_private_route_table" = module.VPC1.vpc.id
            "propagating_vgws_for_private_route_table" = []
            associated_routes = {
                Privroute1 =  {
                        cidr_block = "192.168.0.0/16"
                        nat_gateway = module.VPC1_Gateways.nat_gateway_id_useast1a.id
                    }
                Privroute2 =  {
                        cidr_block = "192.168.0.0/16"
                        nat_gateway = module.VPC1_Gateways.nat_gateway_id_useast1b.id
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

        # Each argument creates a new route table
        # Argument names must be unique.

        RouteTable1 = {
            datatabase_route_table_name = "PublicRouteTable"
            "vpc_id_for_database_route_table" = module.VPC1.vpc.id
            "propagating_vgws_for_database_route_table" = []
            associated_routes = {
                DBroute1 =  {
                        cidr_block = "192.168.0.0/16"
                    }
            }
            database_route_table_tags = {
                "public" = "table"
                }
            }
        

        RouteTable2 = {
            datatabase_route_table_name = "PublicRouteTable"
            "vpc_id_for_database_route_table" = module.VPC1.vpc.id
            "propagating_vgws_for_database_route_table" = []
            associated_routes = {
                DBroute1 =  {
                        cidr_block = "192.168.0.0/16"
                    }
            }
            database_route_table_tags = {
                "public" = "table"
                }
            }   

        RouteTable3 = {
            datatabase_route_table_name = "PublicRouteTable"
            "vpc_id_for_database_route_table" = module.VPC1.vpc.id
            "propagating_vgws_for_database_route_table" = []
            associated_routes = {
                DBroute1 =  {
                        cidr_block = "192.168.0.0/16"
                    }
            }
            database_route_table_tags = {
                "public" = "table"
            }
        }
    }
  
}