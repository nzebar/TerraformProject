module "SUBNETS_VPC1" {
  source = "../../../Modules/Network-Modules/Default-modules/Subnets-Module-Default"


########################
## Availability Zones ##
########################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
# Ref lines 243 - 262 of main.tf file.

    include_all_availability_zones = true
    filter_az_by_state = ""
    filter_az_by_name_value = {}
    excluded_zone_names = []
    excluded_zone_ids = []

#############################
## Declared Public Subnets ##
#############################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# Ref lines 265 - 305 of main.tf file.
public_subnets = {

    subnet1 = {
        "vpc_id" = [module.VPC_VPC1.vpc.id]
        "public_subnet_name" = ["subnetone"]
        "cidr_block" = ["192.168.1.0/24"]
        "availability_zone" = ["us-east-1a"]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "tags" = [{
            "public" = "subnet1",
        }]
    }

    subnet2 = {
        "vpc_id" = [module.VPC_VPC1.vpc.id]
        "public_subnet_name" = ["subnettwo"]
        "cidr_block" = ["192.168.2.0/24"]
        "availability_zone" = ["us-east-1b"]
        "availability_zone_id" = [""]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "tags" = [{
            "public" = "subnet2",
        }]
    }


}

##############################
## Declared Private Subnets ##
##############################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# Ref lines 307 - 347 of main.tf file.

private_subnets = {
    subnet1 = {
        "vpc_id" = [module.VPC_VPC1.vpc.id]
        "private_subnet_name" = [""]
        "cidr_block" = ["192.168.3.0/24"]
        "availability_zone" = ["us-east-1a"]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "tags" = [{
            "private" = "subnet1",
        }]
    }

    subnet2 = {
        "vpc_id" = [module.VPC_VPC1.vpc.id]
        "private_subnet_name" = [""]
        "cidr_block" = ["192.168.4.0/24"]
        "availability_zone" = ["us-east-1b"]
        "availability_zone_id" = [""]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "tags" = [{
            "private" = "subnet2",
        }]
    }


}

##############################
## Declared Database Subnets ##
##############################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# Ref lines 265 - 305 of main.tf file.
# If you would like to not create these resources, comment out the lines referenced above.

database_subnets = {
    subnet1 = {
        "vpc_id" = [module.VPC_VPC1.vpc.id]
        "database_subnet_name" = [""]
        "cidr_block" = ["192.168.5.0/24"]
        "availability_zone" = ["us-east-1a"]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "tags" = [{
            "database" = "subnet1",
        }]
    }

    subnet2 = {
        "vpc_id" = [module.VPC_VPC1.vpc.id]
        "database_subnet_name" = [""]
        "cidr_block" = ["192.168.6.0/24"]
        "availability_zone" = ["us-east-1b"]
        "availability_zone_id" = [""]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "tags" = [{
            "database" = "subnet2",
        }]
    }

    subnet3 = {
        "vpc_id" = [module.VPC_VPC1.vpc.id]
        "database_subnet_name" = [""]
        "cidr_block" = ["192.168.7.0/24"]
        "availability_zone" = ["us-east-1c"]
        "availability_zone_id" = [""]
        "customer_owned_ipv4_pool" = [""] 
        "assign_ipv6_address_on_creation" = ["false"]
        "ipv6_cidr_block" = [""]
        "map_customer_owned_ip_on_launch" = ["false"]
        "map_public_ip_on_launch" = ["false"]
        "outpost_arn" = [""]
        "tags" = [{
            "database" = "subnet3"
        }]
    }


  }



  
}