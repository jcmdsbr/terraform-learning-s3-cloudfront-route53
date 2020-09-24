terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

data "template_file" "policy" {
  template = file("templates/policy.json")

  vars = {
    bucket_name = var.aws_domain
  }
}

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = var.aws_credentials_file
  profile                 = var.aws_profile
}