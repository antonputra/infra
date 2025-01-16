module "node-app" {
  source = "../../modules/app-v2"

  name        = "deno-app"
  app_version = "v0.2.0"
  app_repo    = "424432388155.dkr.ecr.us-east-2.amazonaws.com/node-app"
  app_port    = 8080
  app_cpu     = 1024
  app_memory  = 512
  task_envs   = []

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
}
