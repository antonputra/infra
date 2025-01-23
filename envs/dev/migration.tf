module "migration" {
  source = "../../modules/migration"

  name        = "migration"
  app_version = "v0.1.8"
  app_repo    = "aputra/migration"
  app_port    = 5432
  app_cpu     = 1024
  app_memory  = 512
  replicas    = 1
  task_envs = [
    {
      name  = "PGUSER",
      value = "temporal"
    },
    {
      name  = "PGPASSWORD",
      value = local.db_creds.password
    },
    {
      name  = "PGHOST",
      value = "postgres.dev.exotic.pvt"
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
}
