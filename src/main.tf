terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jcmds"
    workspaces {
      name = "terraform-static-deploy-example"
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
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_s3_bucket" "logger" {
  bucket = "${var.aws_domain}-logger"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "webapp" {
  bucket = var.aws_domain
  acl    = "public-read"
  policy = data.template_file.policy.rendered

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  logging {
    target_bucket = aws_s3_bucket.logger.id
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket" "redirect" {
  bucket = "www.${var.aws_domain}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = var.aws_domain
  }
}

resource "null_resource" "webapp_files" {
  triggers = {
    react_build = md5(file("./app/dist/app/index.html"))
  }

  provisioner "local-exec" {
    command = "aws s3 sync ./app/dist/app/ s3://${var.aws_domain}"
  }

  depends_on = [aws_s3_bucket.webapp]
}
