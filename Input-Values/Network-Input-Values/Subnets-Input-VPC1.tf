module "SUBNETS_VPC1" {
  source = "../../Modules/Network-Modules/Default-modules/Subnets-Module-Default"

########################
## Availability Zones ##
########################

    include_all_availability_zones = true
    filter_az_by_state = ""
    filter_az_by_name_value = {}
    excluded_zone_names = []
    excluded_zone_ids = []

#############################
## Declared Public Subnets ##
#############################

subnets = {

    ####################
    ## Public Subnets ##
    ####################

    public_subnet_1 = {
        subnet_name = "public_subnet_1"
        vpc_id = module.VPC_VPC1.vpc.id
        cidr_block = "192.168.1.0/24"
        availability_zone = "us-east-1a"
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""

        route_table_association = module.VPC1_ROUTE_TABLES.Public_Route_Table_1.id

        tags = {
            "Public_Subnet" = "Public_Subnet_1",
        }
    }

    public_subnet_2 = {
        subnet_name = "public_subnet_2"
        vpc_id = module.VPC_VPC1.vpc.id
        cidr_block = "192.168.2.0/24"
        availability_zone = "us-east-1b"
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""

        route_table_association = module.VPC1_ROUTE_TABLES.Public_Route_Table_2.id

        tags = {
            "Public_Subnet" = "Public_Subnet_2",
        }
    }

    #####################
    ## Private Subnets ##
    #####################

    private_subnet_1 = {
        subnet_name = "private_subnet_1"
        vpc_id = module.VPC_VPC1.vpc.id
        cidr_block = "192.168.3.0/24"
        availability_zone = "us-east-1a"
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""

        route_table_association = module.VPC1_ROUTE_TABLES.Private_Route_Table_1.id

        tags = {
            "Private_Subnet" = "Private_Subnet_1",
        }
    }

    private_subnet_2 = {
        subnet_name = "private_subnet_2"
        vpc_id = module.VPC_VPC1.vpc.id
        cidr_block = "192.168.4.0/24"
        availability_zone = "us-east-1b"
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""

        route_table_association = module.VPC1_ROUTE_TABLES.Private_Route_Table_2.id

        tags = {
            "Private_Subnet" = "Private_Subnet_2",
        }
    }

    ######################
    ## Database Subnets ##
    ######################

    database_subnet_1 = {
        subnet_name = "database_subnet_1"
        vpc_id = module.VPC_VPC1.vpc.id
        cidr_block = "192.168.5.0/24"
        availability_zone = "us-east-1a"
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""

        route_table_association = module.VPC1_ROUTE_TABLES.Database_Route_Table_1.id

        tags = {
            "Database_Subnet" = "Database_Subnet_1",
        }
    }

    database_subnet_2 = {
        subnet_name = "database_subnet_2"
        vpc_id = module.VPC_VPC1.vpc.id
        cidr_block = "192.168.6.0/24"
        availability_zone = "us-east-1b"
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""

        route_table_association = module.VPC1_ROUTE_TABLES.Database_Route_Table_2.id

        tags = {
            "Database_Subnet" = "Database_Subnet_2",
        }
    }

    database_subnet_3 = {
        subnet_name = "database_subnet_3"
        vpc_id = module.VPC_VPC1.vpc.id
        cidr_block = "192.168.7.0/24"
        availability_zone = "us-east-1c"
        customer_owned_ipv4_pool = "" 
        assign_ipv6_address_on_creation = false
        ipv6_cidr_block = ""
        map_customer_owned_ip_on_launch = false
        map_public_ip_on_launch = false
        outpost_arn = ""

        route_table_association = module.VPC1_ROUTE_TABLES.Database_Route_Table_3.id

        tags = {
            "Database_Subnet" = "Database_Subnet_3",
        }
    }
  
}

}