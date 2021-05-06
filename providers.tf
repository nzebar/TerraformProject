terraform {
  required_providers {
     aws = {
      source  = "hashicorp/aws" //The source for where to pull terraform modules from
     # version = "~> 2.0" //Pull all compatible modules above version 2.70 
     }
     
     github = {
       source = "integrations/github"
     }
  } 

}

provider "aws" {
  region                  = "us-east-1" //AWS destination region for terraform modules
  #shared_credentials_file = AWS_SHARED_CREDENTIALS_FILE
  profile = "AWSeducate"//Profile used to provision and destroy resources.
}

provider "github" {
  alias = "githubOAuth"
  owner = "nzebar"
  token = "44b06c41373f2007784de6ba5254a34ba51d3907"
}

# module "Get_IAM_Groups_Users_Input_Values" {
#   source = ""
# }

#################
## IAM Modules ##
#################       

module "GET_IAM_ROLES_POLICIES" {
source = "./Input-Values/Security/IAM"
}

#####################
## Compute Modules ##
#####################       

module "GET_COMPUTE_MODULES" {
source = "./Input-Values/Compute"
}

       
#####################
## Network Modules ##
#####################

module "GET_NETWORK_MODULES" {
  source = "./Input-Values/Network-Input-Values"
}

#####################
## Storage Modules ##
#####################

module "GET_STORAGE_MODULES" {
  source = "./Input-Values/Storage"
}