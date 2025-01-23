# data "aws_route53_zone" "public" {
#   name         = "antonputra.com"
#   private_zone = false
# }

# resource "aws_acm_certificate" "demo" {
#   domain_name       = "demo.antonputra.com"
#   validation_method = "DNS"
# }

# resource "aws_route53_record" "demo" {
#   for_each = {
#     for dvo in aws_acm_certificate.demo.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.public.zone_id
# }

# resource "aws_acm_certificate_validation" "demo" {
#   certificate_arn         = aws_acm_certificate.demo.arn
#   validation_record_fqdns = [for record in aws_route53_record.demo : record.fqdn]
# }
