module "temporal-ui" {
  source = "../../modules/app-lb"

  name         = "temporal-ui"
  app_version  = "2.31.2"
  app_repo     = "temporalio/ui"
  app_port     = 8080
  health_check = "curl -f http://localhost:8080/ || exit 1"
  app_cpu      = 1024
  app_memory   = 256
  replicas     = 1
  task_envs = [
    {
      name  = "TEMPORAL_ADDRESS",
      value = "temporal.dev.exotic.ecs:7233"
    },
    {
      name  = "TEMPORAL_CORS_ORIGINS",
      value = "http://localhost:3000"
    }
  ]

  task_execution_role_arn = module.ecs.task_execution_role_arn
  ecs_name                = module.ecs.ecs_name

  region                         = var.region
  env                            = var.env
  subnets                        = module.vpc.private_subnets
  aws_ecs_capacity_provider_name = module.ecs.aws_ecs_capacity_provider_name
  ecs_id                         = module.ecs.id
  ecs_sg_id                      = module.ecs.sg_id
  vpc_id                         = module.vpc.vpc_id
  public_subnet1                 = module.vpc.public_subnets[0]
  public_subnet2                 = module.vpc.public_subnets[1]
  cert_arn                       = "arn:aws:acm:us-east-2:424432388155:certificate/d96c5fcf-24d4-4f3a-8a77-0a75792757e3"
}
