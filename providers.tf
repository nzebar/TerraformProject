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