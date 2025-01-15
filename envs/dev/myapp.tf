# 100% nginx 
# module "nginx" {
#   source = "../../modules/app"

#   name        = "myapp"
#   app_version = "v26"
#   app_repo    = "424432388155.dkr.ecr.us-east-2.amazonaws.com/app"
#   app_port    = 8080
#   app_cpu     = 1024
#   app_memory  = 512
#   task_envs = [
#     {
#       name  = "BACKEND",
#       value = "http://myapp:8080"
#     }
#   ]

#   enable_ui = false

#   task_execution_role_arn = module.ecs.task_execution_role_arn
#   ecs_name                = module.ecs.ecs_name

#   region                         = var.region
#   env                            = var.env
#   subnets                        = module.vpc.private_subnets
#   aws_ecs_capacity_provider_name = module.ecs.aws_ecs_capacity_provider_name
#   ecs_id                         = module.ecs.id
#   ecs_sg_id                      = module.ecs.sg_id
# }

module "myapp" {
  source = "../../modules/app"

  name        = "myapp"
  app_version = "v26"
  app_repo    = "424432388155.dkr.ecr.us-east-2.amazonaws.com/app"
  app_port    = 8080
  app_cpu     = 1024
  app_memory  = 512
  task_envs = [
    {
      name  = "POSTGRES_HOST",
      value = "postgres.antonputra.pvt"
    }
  ]

  enable_ui = false

  task_execution_role_arn = module.ecs.task_execution_role_arn
  ecs_name                = module.ecs.ecs_name

  region                         = var.region
  env                            = var.env
  subnets                        = module.vpc.private_subnets
  aws_ecs_capacity_provider_name = module.ecs.aws_ecs_capacity_provider_name
  ecs_id                         = module.ecs.id
  ecs_sg_id                      = module.ecs.sg_id
}
