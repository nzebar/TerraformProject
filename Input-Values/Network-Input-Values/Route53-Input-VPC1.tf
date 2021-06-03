module "ROUTE53_VPC1" {
    source = "../../Modules/Network-Modules/Default-modules/Route53-Modules-Default"

###########################
## Route53: Hosted Zones ##
###########################

hosted_zones = {

        Zone1 = {
            name = "nutsandbolts.com"
            comment = "This is a hosted zone"
            force_destroy = true
            delegation_set_id = ""

            private_zone = true
            private_zone_settings = {
                vpc_id = module.VPC_VPC1.vpc.id
                vpc_region = "us-east-1"
            }
        tags = {
            "HostedZone" = "One"
            }
        }
        
}

###########################
## Route53: Zone Records ##
###########################

route53_records = {
    record_1 = {
        zone_key = "Zone1"
        name = "testrecord1"
        type = "A" 
        ttl = 40 # Null if create_alias == true
        multivalue_answer_routing_policy = true
        records = ["192.168.0.5"] # null if create_alias == true
        health_check_id = ""

        set_identifier = "faliover"
        policy = {}

        create_alias = false
        alias = {
            values = {
                name = "thebomb.com"
                zone_key = "Zone1"
                evaluate_target_health = true
            }
        }

        allow_overwrite = true
    }

    record_2 = {
        zone_key = "Zone1"
        name = "testrecord2"
        type = "A" 
        ttl = 40 # Null if create_alias == true
        multivalue_answer_routing_policy = false
        records = ["192.168.0.6"] # null if create_alias == true
        health_check_id = ""

        set_identifier = "weighted"
        policy = {
            weight = 75
        }

        create_alias = false
        alias = {
            values = {
                name = "thebomb.com"
                zone_key = "Zone1"
                evaluate_target_health = true
            }
        }

        allow_overwrite = true
    }

    record_3 = {
        zone_key = "Zone1"
        name = "testrecord3"
        type = "A" 
        ttl = 40 # Null if create_alias == true
        multivalue_answer_routing_policy = false
        records = ["192.168.0.7"] # null if create_alias == true
        health_check_id = ""

        set_identifier = ""
        policy = {}

        create_alias = false
        alias = {
            values = {
                name = "thebomb.com"
                zone_key = "Zone1"
                evaluate_target_health = false
            }
        }

        allow_overwrite = true
    }
}



    







}