##############################   
## Aurora Cluster Variables ##
##############################
variable "create_cluster" {
  description = "Whether to create serverless cluster or not"
  type = bool
  default = false
}

variable "global_cluster_identifier" {
  description = "The global cluster identifier specified on aws_rds_global_cluster"
  type = string
  default = null
}

variable "cluster_identifier" {
  description = "Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier"
  type = string
  default = null
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot"
  type = string
  default = null
}

variable "source_region" {
  description = "The source region for an encrypted replica DB cluster"
  type = string
  default = null
}

variable "replication_source_identifier" {
  description = "ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. If DB Cluster is part of a Global Cluster, use the lifecycle configuration block ignore_changes argument to prevent Terraform from showing differences for this argument instead of configuring this value"
  type = string
  default = null
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection for the cluster"
  type = bool
  default = null
}

variable "create_s3_import" {
    description = "whether to create an S3 import"
    type = bool
    default = false
}

variable "s3_import" {
  description = "S3 bucket to be used for importing db image"
  type = map(string)
  default = null
}

variable "database_name" {
    description = "Name for an automatically created database on cluster creation. There are different naming restrictions"
    type = string
    default = null  
}

variable "db_cluster_parameter_group_name" {
  description = "A cluster parameter group to associate with the cluster." 
  type = string
  default = null
}

variable "engine_mode" {
  description = "The database engine mode"
  type = string
  default = null
}

variable "engine_version" {
  description = "The database engine version"
  type = string
  default = null
}

variable "allow_major_version_upgrade" {
  description = "Enable to allow major engine version upgrades when changing engine versions "
  type = bool
  default = null
}

variable "db_port" {
  description = "The for the db instance to send traffic through"
  type = number
  default = null
}

variable "enable_http_endpoint" {
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless"
  type = bool
  default = null
}

variable "iam_database_authentication_enabled" {
    description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
    type = bool
    default = null  
}

variable "storage_encrypted" {
  description = "pecifies whether the DB cluster is encrypted."
  type = bool
  default = true
}

variable "kms_key_id" {
    description = "The ARN for the KMS encryption key"
    type = string
    default = null  
}

variable "iam_roles" {
  description = "IAM ARN used for the DB instances"
  type = list(string)
  default = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate with the Cluster"
  type = set(string)
  default = null
}

variable "db_subnet_group_name" {
    description = "A DB subnet group to associate with this DB instance"
    type = string 
    default = null
  
}

variable "availability_zones" {
  description = "A list of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created"
  type = list(string)
  default = null
}

variable "backtrack_window" {
  description = "The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0 "
  type = number
  default = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for "
  type = number
  default = null
}

variable "preferred_backup_window" {
  description = "he daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter "
  type = string
  default = null  
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created "
  type = bool 
  default = null
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made"
  type = string
  default = null
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster tags to snapshots"
  type = bool
  default = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to export to cloudwatch. If omitted, no logs will be exported "
  type = set(string)
  default = null
}

variable "preferred_maintenance_window" {
  description = "value"
  type = string
  default = null
}

variable "master_username" {
  description = "Required unless a snapshot_identifier or replication_source_identifier is provided or unless a global_cluster_identifier is provided when the cluster is the secondary cluster of a global database) Password for the master DB user " 
  type = string
  default = "" 
}

variable "master_password" {
  description = "Required unless a snapshot_identifier or replication_source_identifier is provided or unless a global_cluster_identifier is provided when the cluster is the secondary cluster of a global database) Username for the master DB user "
  type = string
  default = ""
}

variable "create_scaling_configuration" {
  description = "Whether to create a scaling configuration for the serverless cluster "
  type = bool
  default = false
}

variable "scaling_configuration" {
    description = "val Nested attribute with scaling properties. Only valid when engine_mode is set to serverless. More details below"
    type = object({
      auto_pause = bool
      seconds_until_auto_pause = number
      max_capacity = number
      min_capacity = number
      timeout_action = string
    })
    default = null
}

variable "create_restore_to_point_in_time" {
  description = "Whether to create a restore point "
  type = bool
  default = false
}

variable "restore_to_point_in_time" {
  description = "Nested attribute for point in time restore. More details below"
  type = object({
    use_latest_restorable_time = bool
    restore_to_time = string
    source_cluster_identifier = string
    restore_type = string
  })
  default = null
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
  type = bool
  default = false
}

############################################   
## Aurora Database Subnet Group Variables ##
############################################

variable "create_db_subnet_group" {
  description = "Whether to create the DB subnet group or not"
  type = bool
  default = false
}

variable "db_subnet_name" {
  description = "Prefix name for the Database Subnet group"
  type = string
  default = null
}

variable "db_subnet_name_prefix" {
  description = "Prefix name for the Database Subnet group"
  type = string
  default = null
}

variable "db_subnet_description" {
  description = "Description of the db subnet"
  type = string
  default = null
}

variable "db_subnet_ids" {
  description = "One or more subnet IDs to designate for the cluster"
  type = list(string)
  default = null
}

#################################################   
## Aurora Database Cluster Instances Variables ##
#################################################

variable "cluster_instances" {
    description = "Mapping of all the cluster instances for the cluster"
    type = map(any)
    default = null
}

################################################   
## Aurora Database Cluster Endpoint Variables ##
################################################

variable "cluster_endpoints" {
    description = "Mapping of all the cluster endpoints for the cluster instances in the cluster"
    type = map(any)
    default = null
}

#######################################################   
## Aurora Database Cluster Parameter Group Variables ##
#######################################################

variable "cluster_parameter_group_name" {
  description = "Name of the Cluster Parameter Group"
  type = string
  default = null
}

variable "cluster_parameter_group_family" {
  description = "Family of the Cluster Parameter Group"
  type = string
  default = null
}

variable "cluster_parameter_group_description" {
  description = "Description of the Cluster Parameter Group"
  type = string
  default = null
}

variable "cluster_parameter_group_parameters" {
    description = "Parameter of the cluster paramter group"
    type = map(map(string))
  
}

###########################################   
## Aurora Database Cluster Tags Variable ##
###########################################

variable "cluster_tags" {
  description = "Tags for the cluster"
  type = map(string)
  default = null
}