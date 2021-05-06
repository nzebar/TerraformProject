module "AURORA_SERVERLESS_VPC1" {
    source = "../../Modules/Storage-Modules/Default-Modules/Aurora-Serverless_Modules"
    
###############################    
## Aurora Serverless Cluster ##
###############################

    create_cluster = true

    global_cluster_identifier = ""
    cluster_identifier = "yuh"
    snapshot_identifier = ""
    source_region = ""
    replication_source_identifier = ""
    deletion_protection = false

    create_s3_import = false
    s3_import = {
        bucket_name = ""
        bucket_prefix = ""
        ingestion_role = ""
        source_engine = ""
        source_engine_version = "" 
    }

    database_name = ""
    db_cluster_parameter_group_name = ""
    engine_mode = "serverless"
    engine_version = ""
    allow_major_version_upgrade = false
    db_port = 3306
    enable_http_endpoint = false
    iam_database_authentication_enabled = false
    storage_encrypted = true
    kms_key_id = "arn:aws:kms:us-east-1:092968731555:key/key1"
    iam_roles = [""]
    vpc_security_group_ids = [""]
    db_subnet_group_name = ""
    availability_zones = [""]

    backtrack_window = 0
    backup_retention_period = 1
    preferred_backup_window = "01:00-03:00"
    preferred_maintenance_window = "wed:03:30-wed:05:30"
    
    skip_final_snapshot = false
    final_snapshot_identifier = "snapyuh"
    copy_tags_to_snapshot = false

    enabled_cloudwatch_logs_exports = ["audit"]

    master_username = "TheAdmin"
    master_password = "SuperSecretPasswordisABC123"

    create_scaling_configuration = true
    scaling_configuration = {
        auto_pause = true
        seconds_until_auto_pause = 300
        max_capacity = 16
        min_capacity = 1
        timeout_action = "RollbackCapacityChange"
    }

    create_restore_to_point_in_time = false
    restore_to_point_in_time = {
        use_latest_restorable_time = true
        restore_to_time = "8"
        source_cluster_identifier = ""
        restore_type = ""
    }

    apply_immediately = false

###########################################    
## Aurora Cluster: Database Subnet Group ##
###########################################

    create_db_subnet_group = true

    db_subnet_name = "testsubnet"
    #db_subnet_name_prefix = "" 
    db_subnet_description = "yuh"
    db_subnet_ids = [""]

#######################################   
## Aurora Cluster: Cluster Instances ##
#######################################

cluster_instances = {
    instance_1 = {
        identifier         = "aurora-cluster-demo"
        promotion_tier = 0
        availability_zone = ""
        db_subnet_group_name = "" # If db_subnet_group is created, name overrides this value

        instance_class     = "db.r4.large"
        engine             = "aurora" # Required
        engine_version     = "" 
        auto_minor_version_upgrade = true
        db_parameter_group_name = ""
        ca_cert_identifier = "yes"

        preferred_backup_window = ""
        preferred_maintenance_window = ""

        monitoring_interval = 1
        monitoring_role_arn = ""
        
        apply_immediately = false
        
        copy_tags_to_snapshot = false
        tags = {
            "key" = "value"
        }
    }
}

#######################################   
## Aurora Cluster: Cluster Endpoints ##
#######################################

cluster_endpoints = {
    endpoint_1 = {
        cluster_endpoint_identifier = "reader"
        custom_endpoint_type        = "READER"
        cluster_instances_map_key_names_static_members = [
            "instance_1",
        ]
        # cluster_instances_map_key_names_excluded_members = []

        tags = {
            "key" = "value"
        }
    }
}

#############################################   
## Aurora Cluster: Cluster Parameter Group ##
#############################################

    cluster_parameter_group_name = "theyuhgroup"
    cluster_parameter_group_family = "aurora5.6"
    cluster_parameter_group_description = "the yuh description"

    cluster_parameter_group_parameters = {
        parameter_1 = {
            name = "character_set_server"
            value = "utf8"
        }
        parameter_2 = {
            name = "character_set_client"
            value = "utf8"
        }
    }







}