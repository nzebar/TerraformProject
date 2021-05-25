module "ECR_VPC1" {
    source = "../../../Modules/CICD-Modules/ECR-Modules"
    
####################
## ECR Repository ##
####################

    ecr_name = ""
    image_tag_mutability = "MUTABLE"
    scan_on_push = true
    encryption_type = "KMS"
    kms_key = ""
    ecr_tags = {
        "key" = "value"
    }

    repository_policy = {
        policy = <<EOF
        {
            "Version": "2008-10-17",
            "Statement": [
                {
                    "Sid": "new policy",
                    "Effect": "Allow",
                    "Principal": "*",
                    "Action": [
                        "ecr:GetDownloadUrlForLayer",
                        "ecr:BatchGetImage",
                        "ecr:BatchCheckLayerAvailability",
                        "ecr:PutImage",
                        "ecr:InitiateLayerUpload",
                        "ecr:UploadLayerPart",
                        "ecr:CompleteLayerUpload",
                        "ecr:DescribeRepositories",
                        "ecr:GetRepositoryPolicy",
                        "ecr:ListImages",
                        "ecr:DeleteRepository",
                        "ecr:BatchDeleteImage",
                        "ecr:SetRepositoryPolicy",
                        "ecr:DeleteRepositoryPolicy"
                    ]
                }
            ]
        }
        EOF
    }

    create_lifecycle_policy = true
    lifecycle_policy = {
        policy = <<EOF
        {
            "rules": [
                {
                    "rulePriority": 1,
                    "description": "Expire images older than 14 days",
                    "selection": {
                        "tagStatus": "untagged",
                        "countType": "sinceImagePushed",
                        "countUnit": "days",
                        "countNumber": 14
                    },
                    "action": {
                        "type": "expire"
                    }
                }
            ]
        }
        EOF
    }

    create_replication_configuration = false
    replication_configuration = {
        rule = {
            destination_1 = {
                region = ""
                registry_id = "" 
            }
        }
    }


}