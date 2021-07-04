module "ECR_VPC1" {
    source = "../../Modules/CICD-Modules/ECR-Modules"

###############################
## Replication Configuration ##
###############################
create_replication_configuration = false
replication_configuration = {
    rules = {
        destination_1 = {
            region = "us-east-1"
            registry_id = "234614842418" 
        }
        destination_2 = {
            region = "us-west-2"
            registry_id = "732176424572" 
        }
    }
}

####################
## ECR Repository ##
####################
create_ecr_repositories = true
ecr_repositories = {

    ecr_1 = {
        ## ECR Settings ##
        ecr_name = "ecr_yuh"
        image_tag_mutability = "MUTABLE"
        scan_on_push = true
        ## ECR Encryption ##
        encryption_configuration = {
          value = {
            enabled = false
            encryption_type = "KMS"
            kms_key = ""
            new_kms_key = {
                enabled = false
                description = "ECR_001_KMS_001" # Required, must be unqiue
                enable_key_rotation = false
                deletion_window_in_days = 7
                policy = ""
                kms_tags = { "Key" = "Value" }
        }}}
        ## Repository Policy ##
        repository_policy = {
            enabled = true
            module_key = "repo_yuh" # Required, must be unique
            ecr_repo_policy_local_path = "Input-Values\\Testing-Input\\efs-test-policy.json"
        }
        ## Lifecycle Policy ##
        lifecycle_policy = {
            enabled = true
            module_key = "lifecycle_yuh" # Required, must be unique
            ecr_lifecycle_policy_local_path = "Input-Values\\Testing-Input\\efs-test-policy.json"
        }
        ## Tags ##
        ecr_tags = {
            "key" = "value"
        }
    }

}

}