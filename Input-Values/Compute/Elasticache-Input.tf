module "ELASTICACHE" {
    source = "../../Modules/Compute-Modules/Default-Modules/Elasticache-Modules"

##########################################
## Elasticache Global Replication Group ##
##########################################
create_global_replication_group = true

global_replication_group_id_suffix = "yuh_id_suffix_yuh"
global_replication_group_description = ""
primary_replication_group_id = "yuhrep"

###################################
## Elasticache Replication Group ##
###################################
create_elasticache_replication_groups = true
elasticache_replication_groups = {
    replication_group_1 = {
        ## Group Settings ##
        global_replication_group_reader = false
        replication_group_id = "yuhrep"
        replication_group_description = ""
        engine = "redis" # "redis is only supported value"
        engine_version = "5.0.6"
        node_type = "" # Null if global_replication_group_reader == true
        auto_minor_version_upgrade = true
        port = 6379
        parameter_group_name = ""
        new_parameter_group = {
            enabled = true
            name = ""
            family = ""
            parameters = [] # "Name.Value"
            tags = { "key" = "value" }
        }

        ## Clustering & Placement Settings ##
        multi_az_enabled = true
        automatic_failover_enabled = true
        cluster_mode = {
          values = {
            enabled = true 
            num_node_groups = 2
            replicas_per_node_group = 2
          }
        }
        number_cache_clusters = 0
        elasticache_subnet_group_name = ""
        new_elasticache_subnet_group = {
            enabled = true
            new_elasticache_subnet_group_name = "redis_subnet_group"
            description = ""
            existing_subnet_ids = []
            add_new_subnets = {
                enabled = true
                vpc_id = "test"
                cidr_block_az = [
                    "192.168.123.0/24:us-east-1a",
                    "192.168.13.0/24:us-east-1b",
                    ] # "CIDR_Block:AZ"
            }
        }

        ## Security Settings ##
        at_rest_encryption_enabled = true
        transit_encryption_enabled = true
        auth_token = ""
        kms_key_id = ""
        vpc_security_group_ids = []
        create_security_group = true
        security_group = {
            name = "Redis_Security_Group"
            description = "Description YUH"
            vpc_id = ""
            ingress_protocols_ports = ["tcp.6379.6379"] # "protocol.fromport.toport"
            ingress_security_groups = []
            ingress_ipv4_cidr_blocks = []
            ingress_ipv6_cidr_blocks = []
            egress_protocols_ports = [] # "protocol.fromport.toport"
            egress_security_groups = []
            egress_ipv4_cidr_blocks = []
            egress_ipv6_cidr_blocks = []
            security_group_tags = { "severless_security_groups" = "serverless_1_security_group_1"}
        }

        ## Backup & Maintenance Settings ##
        snapshot_arns = []
        snapshot_name = ""
        snapshot_window = ""
        snapshot_retention_limit = 0
        final_snapshot_identifier = ""
        maintenance_window = ""

        ## Alert Settings ##
        notification_topic_arn = ""
        create_notification_topic = false
        new_notification_topic = {
            name = ""
            values = {}
            tags = { "key" = "value" }
        }

        ## Tag Settings ##
        tags = {
            "key" = "value"
        }
    }

}

##########################
## Elasticache Clusters ##
##########################
create_elasticache_clusters = true
elasticache_clusters = {

    cluster_1 = {
        ## Cluster Settings ##
        cluster_id = "memcached001"
        engine = "memcached"
        engine_version = ""
        node_type = ""
        num_cache_nodes = 2
        port = 11211
        parameter_group_name = ""
        new_parameter_group = {
            enabled = false
            name = ""
            family = ""
            parameters = [] # "Name.Value"
            tags = { "key" = "value" }
        }

        ## Redis Only Settings ##
        member_of_replication_group = false
        snapshot_name = ""
        snapshot_arns = [] # Single element list
        snapshot_window = ""
        snapshot_retention_limit = 0
        final_snapshot_identifier = ""
        
        ## Placement Settings ##
        az_mode = "cross-az"
        availability_zone = ""
        preferred_availability_zones = ["us-east-1a", "us-east-1b"]
        elasticache_subnet_group_name = ""
        new_elasticache_subnet_group = {
            enabled = true
            new_elasticache_subnet_group_name = "memcached_subnet_group"
            description = "Subnet group for memcached"
            existing_subnet_ids = [module.VPC_VPC1.database_subnet_1.id, module.VPC_VPC1.database_subnet_2.id]
            add_new_subnets = {
                enabled = false
                vpc_id = ""
                cidr_block_az = [
                    "192.168.123.0/24:us-east-1a",
                    "192.168.13.0/24:us-east-1b",
                    ] # "CIDR_Block:AZ"
            }
        }

        ## Security Settings ##
        security_group_ids = []
        create_elasticache_security_group = true
        elasticache_security_group = {
            name = "memcached_security_group"
            description = "Security Group for Memcached"
            vpc_id = module.VPC_VPC1.vpc.id
            ingress_protocols_ports = ["tcp.11211.11211"] # "protocol.fromport.toport"
            ingress_security_groups = [module.AMI_VPC1.launch_template_security_group]
            ingress_ipv4_cidr_blocks = []
            ingress_ipv6_cidr_blocks = []
            egress_protocols_ports = [] # "protocol.fromport.toport"
            egress_security_groups = []
            egress_ipv4_cidr_blocks = []
            egress_ipv6_cidr_blocks = []
            security_group_tags = { "elasticache_security_groups" = "memcached_security_group"}
        }

        ## Maintenance Settings ##
        maintenance_window = ""

        ## Alert Settings ##
        notification_topic_arn = ""
        create_notification_topic = false
        new_notification_topic = {
            name = "SNSyuh"
            values = {}
            tags = { "key" = "value" }
        }

        ## Overwrite Settings ##
        apply_immediately = false

        ## Tag Settings ##
        tags = {
            "elasticache_clusters" = "memcached_001"
        }
    }

}







    
}