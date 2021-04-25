module "ROUTE53_VPC1" {
    source = "../../../Modules/Network-Modules/Default-modules/Route53-Modules-Default"

###########################
## Route53: Hosted Zones ##
###########################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone

    Hosted_Zones = {
        Zone1 = {
            name = "nutsandbolts.com"
            comment = "This is a hosted zone"
            force_destroy = true
            delegation_set_id = ""

            regions = {
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
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record

    # Get the Hosted Zone ID
    zone_id = module.ROUTE53_VPC1.Hosted_Zone_Zone_1.id
    zone_name = ""
    private_zone = false

    # Create records for the Hosted Zone
    records = [
        {
            name = "testrecord1"
            failover_routing_policy = false
            weighted_routing_policy = false
            latency_routing_policy = false
            geolocation_routing_policy = false
            alias = false
            type = "A"
            records = ["192.168.0.56"]
            set_identifier = ""
            health_check_id = ""
            

                alias = {
                    name = ""
                    zone_id = ""
                    evaluate_target_health = false
                }

                failover_routing_policy = {
                    type = ""
                }

                weighted_routing_policy = {
                    weight = 0
                }

                latency_routing_policy = {
                    region = ""
                }

        }
    ]



    







}