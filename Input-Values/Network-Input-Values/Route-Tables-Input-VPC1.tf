module "VPC1_ROUTE_TABLES" {
    source = "../../Modules/Network-Modules/Default-modules/Route-Table-Modules-Default"

#################################
## Default Route Table Config. ##
#################################

    manage_default_route_table = true
    default_route_table_name = "Default_Route_Table"
    default_route_table_id = module.VPC_VPC1.vpc_default_route_table_id
    default_route_table_propagating_vgws = [] 
    default_route_table_routes = {}

    default_route_table_tags = {
        "Default_Route_Table" = "Default_Route_Table_VPC1"
    }

route_tables = {

########################
## Public Route Table ## 
########################
        
    Public_Route_Table_1 = {
      ## ROUTE TABLE SETTIINGS ##
        route_table_name = "Public_Route_Table_1"
        vpc_id = module.VPC_VPC1.vpc.id
        propagating_vgws = []

      ## ASSOCIATED ROUTES ##
        associated_routes = {
            Public_Route_1 =  {
                cidr_block = "192.168.0.0/16"
                gateway_id     = module.GATEWAYS_VPC1.internet_gateway_igw1.id
                }
        }

      ## ROUTE TABLE TAGS ##
        tags = {
          Public_Route_Table = "Public_Route_Table_1"
          }
    }

    Public_Route_Table_2 = {
      ## ROUTE TABLE SETTIINGS ##
        route_table_name = "Public_Route_Table_2"
        vpc_id = module.VPC_VPC1.vpc.id
        propagating_vgws = []

      ## ASSOCIATED ROUTES ##
        associated_routes = {
          Public_Route_1 =  {
              cidr_block = "192.168.0.0/16"
              "gateway_id"     = module.GATEWAYS_VPC1.internet_gateway_igw1.id
              }
        }

      ## ROUTE TABLE TAGS ##
        tags = {
          Public_Route_Table = "Public_Route_Table_2"
          }
    }

##########################
## Private Route Tables ##
##########################

    Private_Route_Table_1 = {
      ## ROUTE TABLE SETTIINGS ##
        route_table_name = "Private_Route_Table_1"
        vpc_id = module.VPC_VPC1.vpc.id
        propagating_vgws = []

      ## ASSOCIATED ROUTES ##
        associated_routes = {
          # Private_Route_1 =  {
          #     cidr_block = "192.168.0.0/16"
          #     nat_gateway = module.GATEWAYS_VPC1.nat_gateway_id_useast1a.id
          #     }
          # Private_Route_2 =  {
          #     cidr_block = "192.168.0.0/16"
          #     nat_gateway = module.GATEWAYS_VPC1.nat_gateway_id_useast1b.id
          #     }
          }

      ## ROUTE TABLE TAGS ##
        tags = {
          Public_Route_Table = "Private_Route_Table_1"
          }
    }

    Private_Route_Table_2 = {
      ## ROUTE TABLE SETTIINGS ##
        route_table_name = "Private_Route_Table_2"
        vpc_id = module.VPC_VPC1.vpc.id
        propagating_vgws = []

      ## ASSOCIATED ROUTES ##
        associated_routes = {
          # Private_Route_1 =  {
          #     cidr_block = "192.168.0.0/16"
          #     nat_gateway = module.GATEWAYS_VPC1.nat_gateway_id_useast1a.id
          #     }
          # Private_Route_2 =  {
          #     cidr_block = "192.168.0.0/16"
          #     nat_gateway = module.GATEWAYS_VPC1.nat_gateway_id_useast1b.id
          #     }
          }

      ## ROUTE TABLE TAGS ##
        tags = {
          Public_Route_Table = "Private_Route_Table_2"
          }
    }

###########################
## Database Route Tables ##
###########################

    Database_Route_Table_1 = {
      ## ROUTE TABLE SETTIINGS ##
        route_table_name = "Database_Route_Table_1"
        vpc_id = module.VPC_VPC1.vpc.id
        propagating_vgws = []

      ## ASSOCIATED ROUTES ##
        associated_routes = {}

      ## ROUTE TABLE TAGS ##
        tags = {
          Database_Route_Table = "Database_Route_Table_1"
          }
    }

    Database_Route_Table_2 = {
      ## ROUTE TABLE SETTIINGS ##
        route_table_name = "Database_Route_Table_2"
        vpc_id = module.VPC_VPC1.vpc.id
        propagating_vgws = []

      ## ASSOCIATED ROUTES ##
        associated_routes = {}

      ## ROUTE TABLE TAGS ##
        tags = {
          Database_Route_Table = "Database_Route_Table_2"
          }
    }

    Database_Route_Table_3 = {
      ## ROUTE TABLE SETTIINGS ##
        route_table_name = "Database_Route_Table_3"
        vpc_id = module.VPC_VPC1.vpc.id
        propagating_vgws = []

      ## ASSOCIATED ROUTES ##
        associated_routes = {}

      ## ROUTE TABLE TAGS ##
        tags = {
          Database_Route_Table = "Database_Route_Table_3"
          }
    }

}





}