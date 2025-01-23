resource "aws_service_discovery_private_dns_namespace" "ecs" {
  name = "${var.env}.${var.domain}.ecs"
  vpc  = module.vpc.vpc_id
}

module "ecs" {
  source = "../../modules/ecs"

  name          = "main"
  env           = var.env
  vpc_id        = module.vpc.vpc_id
  app_port      = 8080
  image_id      = "ami-0be8d4e5691981cad"
  instance_type = "t3.small"
  min_size      = 0
  max_size      = 5
  subnets       = module.vpc.private_subnets
  alb_sg_ids    = [module.temporal-ui.alb_sg_id]
  # alb_sg_ids = []
}
