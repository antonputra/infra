resource "aws_route53_zone" "this" {
  name = "antonputra.pvt"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
