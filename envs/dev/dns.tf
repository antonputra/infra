resource "aws_route53_zone" "this" {
  name = "${var.env}.${var.domain}.pvt"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
