resource "aws_route53_record" "this" {
  zone_id = var.route53_zone_id
  name    = "postgres.${var.aws_route53_zone_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.this.private_ip]
}
