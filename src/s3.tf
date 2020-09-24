


data "template_file" "policy" {
  template = file("templates/policy.json")

  vars = {
    bucket_name = var.aws_domain
  }
}

resource "aws_s3_bucket" "logger" {
  bucket        = "${var.aws_domain}-logger"
  acl           = "log-delivery-write"
  force_destroy = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "webapp" {
  bucket        = var.aws_domain
  acl           = "public-read"
  policy        = data.template_file.policy.rendered
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  logging {
    target_bucket = aws_s3_bucket.logger.id
    target_prefix = "webapp/"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "redirect" {
  bucket = "www.${var.aws_domain}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = aws_s3_bucket.webapp.website_endpoint
  }
}

resource "null_resource" "webapp_files" {
  triggers = {
    react_build = md5(file("./app/dist/app/index.html"))
  }

  provisioner "local-exec" {
    command = "aws s3 sync ./app/ s3://${var.aws_domain} --profile terraform"
  }

  depends_on = [aws_s3_bucket.webapp]
}
