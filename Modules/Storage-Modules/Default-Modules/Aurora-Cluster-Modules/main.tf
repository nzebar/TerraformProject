####################    
## Aurora Cluster ##
####################

resource "aws_rds_cluster" "default" {
count = var.create_cluster == true ? 1 : 0

global_cluster_identifier = var.global_cluster_identifier
cluster_identifier = var.cluster_identifier
snapshot_identifier = var.snapshot_identifier
source_region = var.source_region
replication_source_identifier = var.replication_source_identifier
deletion_protection = var.deletion_protection

dynamic "s3_import" {
  for_each = var.create_s3_import == true ? [1] : []
    content{
        bucket_name = ""
        bucket_prefix = ""
        ingestion_role = ""
        source_engine = ""
        source_engine_version = ""
  }
}

database_name = var.database_name
db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
engine_mode = var.engine_mode
engine_version = var.engine_version
allow_major_version_upgrade = var.allow_major_version_upgrade
port = var.db_port
enable_http_endpoint = var.enable_http_endpoint
iam_database_authentication_enabled = var.iam_database_authentication_enabled
storage_encrypted = var.storage_encrypted
kms_key_id = var.kms_key_id
iam_roles = var.iam_roles
vpc_security_group_ids = var.vpc_security_group_ids
db_subnet_group_name = var.create_db_subnet_group == true ? aws_db_subnet_group.db_subnet_group[0].name : var.db_subnet_group_name
availability_zones = var.availability_zones

backtrack_window = var.backtrack_window
backup_retention_period = var.backup_retention_period
preferred_backup_window = var.preferred_backup_window
preferred_maintenance_window = var.preferred_maintenance_window
 
skip_final_snapshot = var.skip_final_snapshot
final_snapshot_identifier = var.final_snapshot_identifier
copy_tags_to_snapshot = var.copy_tags_to_snapshot

enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

master_username = var.master_username
master_password = var.master_password

dynamic "scaling_configuration" {
  for_each = var.create_scaling_configuration == true ? [1] : []
  content {
    auto_pause = true
    seconds_until_auto_pause = 300
    max_capacity = 16
    min_capacity = 1
    timeout_action = "RollbackCapacityChange"
  }
}

dynamic "restore_to_point_in_time" {
for_each = var.create_restore_to_point_in_time == true ? [1] : []
  content{
    use_latest_restorable_time = true
    restore_to_time = "8"
    source_cluster_identifier = ""
    restore_type = ""
  }
}

apply_immediately = false

tags = var.cluster_tags

}

#####################################    
## Aurora Cluster: DB Subnet Group ##
#####################################

resource "aws_db_subnet_group" "db_subnet_group" {
count = var.create_db_subnet_group == true ? 1 : 0
  name       = var.db_subnet_name
  name_prefix = var.db_subnet_name_prefix
  description = var.db_subnet_description
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = var.db_subnet_name
  }
}

#######################################   
## Aurora Cluster: Cluster Instances ##
#######################################

resource "aws_rds_cluster_instance" "cluster_instances" {
for_each = var.cluster_instances

    identifier         = lookup(var.cluster_instances[each.key], "identifier", null)
    promotion_tier = lookup(var.cluster_instances[each.key], "promotion_tier", null)
    cluster_identifier = aws_rds_cluster.default[0].cluster_identifier
    availability_zone = lookup(var.cluster_instances[each.key], "availability_zone", null)
    db_subnet_group_name = var.create_db_subnet_group == true ? aws_db_subnet_group.db_subnet_group[0].name : lookup(var.cluster_instances[each.key], "db_subnet_group_name", null)

    instance_class     = lookup(var.cluster_instances[each.key], "instance_class", null)
    engine             = lookup(var.cluster_instances[each.key], "engine", null)
    engine_version     = lookup(var.cluster_instances[each.key], "engine_version", null)
    auto_minor_version_upgrade = lookup(var.cluster_instances[each.key], "auto_minor_version_upgrade", null)
    db_parameter_group_name = lookup(var.cluster_instances[each.key], "db_parameter_group_name", null) == "" ? aws_rds_cluster_parameter_group.default.name : lookup(var.cluster_instances[each.key], "db_parameter_group_name", null)
    ca_cert_identifier = lookup(var.cluster_instances[each.key], "ca_cert_identifier", null)

    preferred_backup_window = lookup(var.cluster_instances[each.key], "preferred_backup_window", null)
    preferred_maintenance_window = lookup(var.cluster_instances[each.key], "preferred_maintenance_window", null)

    monitoring_interval = lookup(var.cluster_instances[each.key], "monitoring_interval", null)
    monitoring_role_arn = lookup(var.cluster_instances[each.key], "monitoring_role_arn", null)

    apply_immediately = lookup(var.cluster_instances[each.key], "apply_immediately", null)

    copy_tags_to_snapshot = lookup(var.cluster_instances[each.key], "copy_tags_to_snapshot", null)
    tags = lookup(var.cluster_instances[each.key], "tags", null)

}

#######################################   
## Aurora Cluster: Cluster Endpoints ##
#######################################

resource "aws_rds_cluster_endpoint" "eligible" {
for_each = var.cluster_endpoints
  cluster_identifier          = aws_rds_cluster.default[0].id
  cluster_endpoint_identifier = lookup(var.cluster_endpoints[each.key], "cluster_endpoint_identifier", [])
  custom_endpoint_type        = lookup(var.cluster_endpoints[each.key], "custom_endpoint_type", [])
  static_members = [ for map_key_names in lookup(var.cluster_endpoints[each.key], "cluster_instances_map_key_names_static_members", [] ): aws_rds_cluster_instance.cluster_instances[map_key_names].id ]
  #excluded_members = [ for map_key_names in lookup(var.cluster_endpoints[each.key], "cluster_instances_map_key_names_excluded_members", [] ): aws_rds_cluster_instance.cluster_instances[map_key_names].id ]

  tags = lookup(var.cluster_endpoints[each.key], "tags", {})
}

#############################################   
## Aurora Cluster: Cluster Parameter Group ##
#############################################

resource "aws_rds_cluster_parameter_group" "default" {
  name        = var.cluster_parameter_group_name
  family      = var.cluster_parameter_group_family
  description = var.cluster_parameter_group_description

  dynamic "parameter" {
    for_each = var.cluster_parameter_group_parameters
    content{
    name  = lookup(parameter.value, "name", null)
    value = lookup(parameter.value, "value", null)
    }
  }
}


