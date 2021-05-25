#############################
## ECR Repository Variable ##
#############################

variable "ecr_name" {
    description = "Name of ECR repository"
    type = string
    default = ""
}

variable "image_tag_mutability" {
    description = "Image tag mutability"
    type = string
    default = null
}

variable "scan_on_push" {
    description = "Whether images are scanned or not when they are pushed to the repo"
    type = bool
    default = true
}

variable "encryption_type" {
    description = "encryption type for the repo"
    type = string
    default = null
}

variable "kms_key" {
    description = "Encryption key for the repo"
    type = string
    default = null
}

variable "ecr_tags" {
    description = "Tags for the ECR Repo"
    type = map(string)
    default = {}
}

####################################
## ECR Repository Policy Variable ##
####################################

variable "repository_policy" {
    description = "String mapping where the value is the policy for the repo"
    type = map(string)
    default = {}
}

##############################################
## ECR Repository Lifecycle Policy Variable ##
##############################################

variable "create_lifecycle_policy" {
    description = "Whether to create a lifecycle policy for the repo or not"
    type = bool
    default = false
}

variable "lifecycle_policy" {
    description = "String mapping where the value is the lifecycle policy for the repo"
    type = map(string)
    default = {}
}

#########################################
## ECR Repository Replication Variable ##
#########################################

variable "create_replication_configuration" {
    description = "Whether to create a replication configuration for the repo"
    type = bool
    default = false
}

variable "replication_configuration" {
    description = "Replication configuration settings for the repo"
    type = map(map(map(string)))
    default = null
}

