####################
## ECR Repository ##
####################

resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.ecr_name
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
  encryption_type = var.encryption_type
  kms_key = var.kms_key
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.ecr_tags
}

###########################
## ECR Repostiory Policy ##
###########################

resource "aws_ecr_repository_policy" "foopolicy" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = var.repository_policy["policy"]
}

##########################
## ECR Lifecycle Policy ##
##########################

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
count = var.create_lifecycle_policy == true ? 1 : 0
  repository = aws_ecr_repository.ecr_repo.name

  policy = var.lifecycle_policy["policy"]
}

##########################
## ECR Lifecycle Policy ##
##########################

resource "aws_ecr_replication_configuration" "example" {
count = var.create_replication_configuration == true ? 1 : 0

  replication_configuration {
    dynamic "rule" {
    for_each = var.replication_configuration["rule"]
    content{
      destination {
        region      = each.value.region
        registry_id = each.value.registry_id
        }
      }
    }
  }
}