module "VPC1_NACLS" {
source = "../../../Modules/Network-Modules/VPC-Modules/Create-VPC/NACL-Modules"


########################
## VPC1: Default NACl ##
########################
default_network_acl = {

    acl1 = {
        default_network_acl_name = "VPC1_Default_acl"
        default_network_acl_id = module.VPC1.vpc.default_network_acl_id
        default_acl_subnet_ids = []

        default_network_acl_ingress = {

            ingress_rule = {
                "action"        = "allow"
                "cidr_block"      = "0.0.0.0/0"
                "from_port"       = 0
                "protocol"        = -1
                "rule_no"         = 10
                "to_port"         = 0
                }

            ingress_rule = {
                "action"        = "allow"
                "cidr_block"      = "0.0.0.0/0"
                "from_port"       = 0
                "protocol"        = -1
                "rule_no"         = 10
                "to_port"         = 0 
                }
            }

        default_network_acl_egress = {

            egress_rule = {
                "action"        = "allow"
                "cidr_block"      = "0.0.0.0/0"
                "from_port"       = 0
                "protocol"        = -1
                "rule_no"         = 10
                "to_port"         = 0
                }
            }

            default_network_acl_tags = {
                "acl" = "default"
            }
        }


}


########################
## VPC1: Public NACl ##
########################
public_network_acl = {

    acl1 = {
        public_network_acl_name = "VPC1_Public_NACL"
        vpc_id_public_acls = module.VPC1.vpc.id
        public_acl_subnet_ids = [
            module.VPC1_Subnets.aws_subnet_public_subnets_subnet1.id,
            module.VPC1_Subnets.aws_subnet_public_subnets_subnet2.id
        ]

        public_network_acl_ingress = {
            ingress_rule = {
                "action"        = "allow"
                "cidr_block"      = "0.0.0.0/0"
                "from_port"       = 0
                "protocol"        = -1
                "rule_no"         = 10
                "to_port"         = 0
                }
            }

        public_network_acl_egress = {
            egress_rule = {
                "action"        = "allow"
                "cidr_block"      = "0.0.0.0/0"
                "from_port"       = 0
                "protocol"        = -1
                "rule_no"         = 10
                "to_port"         = 0
                }
            }

            public_network_acl_tags = {
                "acl" = "public"
            }
        }


}


########################
## VPC1: Private NACl ##
########################
private_network_acl = {

    acl1 = {
        private_network_acl_name = "VPC1_Private_NACL"
        vpc_id_private_acls = module.VPC1.vpc.id
        private_acl_subnet_ids = [
            module.VPC1_Subnets.aws_subnet_private_subnets_subnet1.id,
            module.VPC1_Subnets.aws_subnet_private_subnets_subnet2.id
            ]

        private_network_acl_ingress = {
            ingress_rule = {
                "action"        = "allow"
                "cidr_block"      = "0.0.0.0/0"
                "from_port"       = 0
                "protocol"        = -1
                "rule_no"         = 10
                "to_port"         = 0
                }
            }

        private_network_acl_egress = {
            egress_rule = {
                "action"        = "allow"
                "cidr_block"      = "0.0.0.0/0"
                "from_port"       = 0
                "protocol"        = -1
                "rule_no"         = 10
                "to_port"         = 0
                }
            }

            private_network_acl_tags = {
                "acl" = "private"
            }
        }


}



#########################
## VPC1: Database NACl ##
#########################
database_network_acl = {

    acl1 = {
        database_network_acl_name = "VPC1_Database_NACL"
        vpc_id_database_acls = module.VPC1.vpc.id
        database_acl_subnet_ids = [
            module.VPC1_Subnets.aws_subnet_database_subnets_subnet1.id,
            module.VPC1_Subnets.aws_subnet_database_subnets_subnet2.id,
            module.VPC1_Subnets.aws_subnet_database_subnets_subnet3.id
            ]

            database_network_acl_ingress = {

                ingress_rule = {
                    action        = "allow"
                    cidr_block      = "0.0.0.0/0"
                    from_port     = 0
                    protocol        = -1
                    rule_no         = 10
                    to_port        = 0
                    }
                }

            database_network_acl_egress = {

                egress_rule = {
                    action        = "allow"
                    cidr_block      = "0.0.0.0/0"
                    from_port     = 0
                    protocol        = -1
                    rule_no         = 10
                    to_port        = 0
                }
            }

            database_network_acl_tags = {
                "acl" = "database"
            }
        }


}



}