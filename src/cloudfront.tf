locals {
  s3_origin_id = aws_s3_bucket.webapp.bucket_regional_domain_name
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = local.s3_origin_id
    origin_id   = local.s3_origin_id

    # s3_origin_config {
    #  origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    # }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Managed by Terraform"
  default_root_object = "index.html"

  logging_config {
    include_cookies = true
    bucket          = aws_s3_bucket.logger.bucket_domain_name
    prefix          = "cdn"
  }

  aliases = [var.aws_domain]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all" # use redirect-to-https when ttls
    min_ttl                = 0
    default_ttl            = 3600  # 1 H
    max_ttl                = 86400 # 1 day
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    # cloudfront_default_certificate = false
    # acm_certificate_arn = aws_acm_certificate.cert.arn
    # ssl_support_method = "sni-only"
  }
}

# resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
#   comment = "Managed by Terraform"
# }