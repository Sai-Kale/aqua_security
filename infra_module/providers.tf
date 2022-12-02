########################################
# Provider to connect to AWS
# https://www.terraform.io/docs/providers/aws/
########################################

terraform {
  required_version = ">=1.2.9"
#  backend "s3" {} # use backend.config for remote backend
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.40.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
  profile = var.profile_name
}