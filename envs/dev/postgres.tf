module "postgres" {
  source = "../../modules/postgres"

  env                   = var.env
  vpc_id                = module.vpc.vpc_id
  app_sg_id             = module.ecs.sg_id
  az                    = var.az1
  ebs_type              = "gp3"
  ami                   = "ami-06cc9e6839351b856"
  machine_type          = "t3.small" # use arm64 -> graviton m8g.large
  subnet_id             = module.vpc.private_subnets[0]
  data_disk_size        = 10
  aws_route53_zone_name = aws_route53_zone.this.name
  route53_zone_id       = aws_route53_zone.this.zone_id
}
