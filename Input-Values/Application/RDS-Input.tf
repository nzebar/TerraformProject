module "RDS_VPC1" {
    source = "../../Modules/Compute-Modules/Default-Modules/RDS-Modules"

#################    
## RDS Cluster ##
#################

    create_cluster = true

    global_cluster_identifier           = ""
    cluster_identifier                  = ""
    replication_source_identifier       = ""
    source_region                       = ""
    engine                              = ""
    engine_mode                         = ""
    engine_version                      = ""
    allow_major_version_upgrade         = ""
    enable_http_endpoint                = ""
    kms_key_id                          = ""
    database_name                       = ""
    master_username                     = ""
    master_password                     = ""
    final_snapshot_identifier           = ""
    skip_final_snapshot                 = ""
    deletion_protection                 = ""
    backup_retention_period             = ""
    preferred_backup_window             = ""
    preferred_maintenance_window        = ""
    port                                = ""
    
    vpc_security_group_ids              = ""
    snapshot_identifier                 = ""
    storage_encrypted                   = ""
    apply_immediately                   = ""
    db_cluster_parameter_group_name     = ""
    iam_database_authentication_enabled = ""
    backtrack_window                    = ""
    copy_tags_to_snapshot               = ""
    iam_roles                           = ""

    enabled_cloudwatch_logs_exports = false

    create_db_subnet_group = true
      db_subnet_group_name     = ""
      db_subnet_group_description = ""
      subnets = [""]

    create_scaling_configuration = false
        scaling_configuration = {
        auto_pause               = "" 
        max_capacity             = ""
        min_capacity             = ""
        seconds_until_auto_pause = ""
        timeout_action           = ""
      }

    create_s3_import = false
      s3_import = {
        source_engine         = ""
        source_engine_version = ""
        bucket_name           = ""
        bucket_prefix         = ""
        ingestion_role        = ""
      }

    create_restore_to_point_in_time = false
      restore_to_point_in_time = {
        source_cluster_identifier  = "example"
        restore_type               = "copy-on-write"
        use_latest_restorable_time = true
        restore_to_time = "" # UTF Format
    }

    cluster_tags = {
        "key" = "value"
    }

    tags = {
        "key" = "value"
    }

##########################    
## RDS Cluster Instance ##
##########################

    identifier                      = 
    cluster_identifier              = 
    engine                          = 
    engine_version                  = 
    instance_class                  = 
    publicly_accessible             = 
    db_subnet_group_name            = 
    db_parameter_group_name         = 
    preferred_maintenance_window    = 
    apply_immediately               = 
    monitoring_role_arn             = 
    monitoring_interval             = 
    auto_minor_version_upgrade      = 
    promotion_tier                  = 
    performance_insights_enabled    = 
    performance_insights_kms_key_id = 
    ca_cert_identifier              = 

    cluster_instance_tags = {
        "key" = "value"
    }
    
}