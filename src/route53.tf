# resource "aws_route53_zone" "primary" {
#   name    = var.aws_domain
#   comment = "Managed by Terraform when DNS not registered"
# }


# # Configuration domain zone and records

# data "aws_route53_zone" "webapp" {
#   name         = "${var.aws_domain}."
#   private_zone = false
# }

# resource "aws_route53_record" "webapp" {
#   zone_id = data.aws_route53_zone.webapp.zone_id
#   name    = var.aws_domain
#   type    = "A"

#   alias {
#     name                   = aws_cloudfront_distribution.s3_distribution.domain_name
#     zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
#     evaluate_target_health = false
#   }

#  depends_on = [aws_cloudfront_distribution.s3_distribution]
# }

# resource "aws_route53_record" "www" {
#   zone_id = data.aws_route53_zone.webapp.zone_id
#   name    = "www.${var.aws_domain}"
#   type    = "A"

#   alias {
#     name                   = aws_s3_bucket.redirect.website_domain
#     zone_id                = aws_s3_bucket.redirect.hosted_zone_id
#     evaluate_target_health = false
#   }
# }